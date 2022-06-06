from flask import Flask, redirect, render_template, request, session
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
import os
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  FileStorage
import math

with open('static/config.json', 'r') as c:
    params = json.load(c) ["params"]

app = Flask(__name__)
app.secret_key = 'super-secret-key'

if(params['local_server']):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['pord_uri']

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

app.config['UPLOAD_FOLDER']=params['update_location']

db = SQLAlchemy(app)
# mail = Mail(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.DateTime,nullable=True)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    subtitle = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.DateTime,nullable=True)
    img_file= db.Column(db.String(20), nullable=True)

@app.route('/')
def home():

    posts=Posts.query.all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    print(str(page))
    if(not str(page).isnumeric()):
        page = 1
    page=int(page)

    posts=posts[(page-1)*int(params['no_of_posts']) : (page-1)*int(params['no_of_posts']) + int(params['no_of_posts'])]
    #Pagination Logic
    if page==1:
        prev="#"
        next="/?page="+str(page+1)
    elif page==last:
        prev="/?page="+str(page-1)
        next="#"
    else:
        prev="/?page="+str(page-1)
        next="/?page="+str(page+1)

    return render_template("index.html", params=params, posts=posts, prev=prev, next=next)

@app.route('/about')
def about():
    return render_template("about.html", params=params)

@app.route('/contact', methods=['GET','POST'])
def contact():
    if request.method=='POST':
       name = request.form['name']
       email = request.form['email']
       phone = request.form['phone']
       msg = request.form['message']
       contact = Contacts(name=name, email=email, phone_num=phone,msg=msg,date=datetime.now())
       db.session.add(contact)
       db.session.commit()

    return render_template("contact.html", params=params)

@app.route('/post/<string:post_slug>', methods=['GET'])
def post_route(post_slug):
    if ('user' in session and session['user'] == params['admin_user']):
        result=Posts.query.filter_by(slug=post_slug).first()
        return render_template("post.html", params=params, result=result)

    return render_template('login.html', params=params)

@app.route('/login', methods=['GET','POST'])
def dashboard():
    posts= Posts.query.all()
    if ('user' in session and session['user'] == params['admin_user']):
        return render_template("dashboard.html", params=params, posts=posts)

    if request.method=='POST':
        username=request.form['email']
        password=request.form['password']
        if (username==params['admin_user'] and password==params['admin_password']):
            #set the session variable
            session['user'] = username
            # posts= Posts.query.all()
            return render_template("dashboard.html", params=params, posts=posts)
    else:
        return render_template("login.html", params=params)

@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def editPosts(sno):
    posts=Posts.query.all()
    result=Posts.query.filter_by(sno=int(sno)).first()
    if ('user' in session and session['user'] == params['admin_user']):
        if(request.method=='POST'):
            box_title=request.form['title']
            box_subtitle=request.form['subtitle']
            box_slug=request.form['slug']
            box_content=request.form['content']
            box_img_file=request.form['imgfile']
            result.title=box_title
            result.subtitle=box_subtitle
            result.slug=box_slug
            result.content=box_content
            result.img_file=box_img_file
            result.date=datetime.now()
            db.session.add(result)
            db.session.commit()
            return render_template("dashboard.html", params=params, posts=posts)


        # result=Posts.query.filter_by(sno=int(sno)).first()
        return render_template('edit.html', params=params, result=result)

@app.route("/delete/<string:sno>", methods=['GET', 'POST', 'PUT', 'DELETE'])
def deletePosts(sno):
    if ('user' in session and session['user'] == params['admin_user']):
            post=Posts.query.filter_by(sno=int(sno)).first()
            db.session.delete(post)
            db.session.commit()

    posts=Posts.query.all()
    return render_template("dashboard.html", params=params, posts=posts)


@app.route("/add", methods=['GET','POST'])
def addPost():
    if request.method=='POST':
        box_title=request.form['title']
        box_subtitle=request.form['subtitle']
        box_slug=request.form['slug']
        box_content=request.form['content']
        box_img_file=request.form['imgfile']
        post=Posts(title=box_title,subtitle=box_subtitle,slug=box_slug,content=box_content,img_file=box_img_file,date=datetime.now())
        db.session.add(post)
        db.session.commit()
        posts=Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)

    return render_template("add.html", params=params)

@app.route("/uploader", methods=['GET','POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method=='POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"

@app.route("/logout", methods=['GET'])
def logout():
    session.pop('user')
    return redirect('/login')

@app.route("/search", methods=['GET'])
def search():
    val = request.args.get('searched')
    print(val)
    if val:
        posts=Posts.query.filter(Posts.title.contains(val) |
        Posts.content.contains(val))
    else:
        posts=Posts.query.all()
    return render_template("search.html", params=params, posts=posts)
    

app.run(debug=True)