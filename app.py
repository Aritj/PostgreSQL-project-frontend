#!/usr/bin/env python
'''
Connector for creating TCP sockets to MAE and HSS servers.
Also responsible for sending and receiving encoded commands.
'''

# Standard library imports
import json
import datetime

# Import Flask microservices
from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

# Import configuration
import configuration as conf

app = Flask(__name__)
postgresql_string = f'postgresql://{conf.DB_USERNAME}:{conf.DB_PASSWORD}@{conf.DB_IP}/{conf.DB_NAME}'
app.config['SQLALCHEMY_DATABASE_URI'] = postgresql_string
db = SQLAlchemy(app)

class Zip(db.Model):
	zip_code = db.Column(db.Integer, primary_key = True)
	city = db.Column(db.String(30))
	def __init__(self, zip_code, city):
		self.zip_code = zip_code
		self.city = city
	def __repr__(self):
		return '<City %r>' % self.city

class Person(db.Model):
	ptal = db.Column(db.String(9), primary_key = True)
	first_name = db.Column(db.String(30), nullable = False)
	middle_name = db.Column(db.String(30))
	last_name = db.Column(db.String(30), nullable = False)
	street_name = db.Column(db.String(30), nullable = False)
	street_number = db.Column(db.Integer, nullable = False)
	email = db.Column(db.String(50), nullable = False, unique = True)
	phone_number = db.Column(db.Integer, nullable = False)
	zip_code = db.Column(db.Integer, db.ForeignKey('Zip.zip_code'), nullable = False)

class Customer(db.Model):
	customer_id = db.Column(db.Integer, primary_key = True)
	creation_date = db.Column(db.Date, default = datetime.datetime.now)
	ptal = db.Column(db.String(9), db.ForeignKey('person.ptal'), nullable = False)
	def __init__(self, customer_id, creation_date, ptal):
		self.customer_id = customer_id
		self.creation_date = creation_date
		self.ptal = ptal
	def __repr__(self):
		return '<customer_id %r>' % self.customer_id

class Employee(db.Model):
	employee_id = db.Column(db.Integer, primary_key = True)
	job_title = db.Column(db.String(30), nullable = False)
	employment_date = db.Column(db.Date, default = datetime.datetime.now)
	ptal = db.Column(db.String(9), db.ForeignKey('person.ptal'), nullable = False)

class Accounttype(db.Model):
	account_type = db.Column(db.Integer, primary_key = True)
	type_name = db.Column(db.String(30), nullable = False)
	rent = db.Column(db.Float, nullable = False)
	def __init__(self, account_type, type_name, rent):
		self.account_type = account_type
		self.type_name = type_name
		self.rent = rent
	def __repr__(self):
		return self.type_name

class Account(db.Model):
	account_id = db.Column(db.Integer, primary_key = True)
	balance = db.Column(db.Float, nullable = False)
	creation_date = db.Column(db.Date, default = datetime.datetime.now)
	account_type = db.Column(db.Integer, db.ForeignKey('AccountType.account_type'), nullable = False)
	customer_id = db.Column(db.Integer, db.ForeignKey('Customer.customer_id'), nullable = False)

class Bank(db.Model):
	vtal = db.Column(db.Integer, primary_key = True)
	name = db.Column(db.String(50), nullable = False)
	street_name = db.Column(db.String(50), nullable = False)
	street_number = db.Column(db.Integer, nullable = False)
	email = db.Column(db.String(50), nullable = False, unique = True)
	phone_number = db.Column(db.Integer, nullable = False)
	zip_code = db.Column(db.Integer, db.ForeignKey('Zip.zip_code'), nullable = False)
	equity = db.Column(db.Integer, db.ForeignKey('Account.account_id'), nullable = False)
	balance = db.Column(db.Integer, db.ForeignKey('Account.account_id'), nullable = False)

class Transactions(db.Model):
	transaction_id = db.Column(db.Integer, primary_key = True)
	amount = db.Column(db.Integer, nullable = False)
	creation_date = db.Column(db.Date, default = datetime.datetime.now)
	account = db.Column(db.Integer, db.ForeignKey('Account.account_id'), nullable = False)
	balance = db.Column(db.Float, nullable = False)


class Relation(db.Model):
	relation_type = db.Column(db.String(30), primary_key = True)
	partner_or_parent = db.Column(db.String(9), db.ForeignKey('person.ptal'), nullable = False)
	partner_or_child = db.Column(db.String(9), db.ForeignKey('person.ptal'), nullable = False)

class Cashdraft(db.Model):
	operator = db.Column(db.Integer, primary_key = True)
	date = db.Column(db.Date, default = datetime.datetime.now)
	balance = db.Column(db.Float, nullable = False)
	account_id = db.Column(db.Integer, db.ForeignKey('Account.account_id'), nullable = False)
	employee_id = db.Column(db.Integer, db.ForeignKey('Employee.employee_id'), nullable = False)

class Customerlogin(db.Model):
	username = db.Column(db.String(50), primary_key = True)
	customer_id = db.Column(db.Integer, db.ForeignKey('Customer.customer_id'), nullable = False)
	def __init__(self, username):
		self.username = username
	def __repr__(self):
		return self.username

class Employeelogin(db.Model):
	username = db.Column(db.String(50), primary_key = True)
	employee_id = db.Column(db.Integer, db.ForeignKey('Employee.employee_id'), nullable = False)
	def __init__(self, username):
		self.username = username
	def __repr__(self):
		return self.username

@app.route('/', methods = ['GET'])
def index():
	return render_template('index.html', login = False)

@app.route('/developers', methods = ['GET'])
def developers_route():
	return render_template('developers.html')

@app.route('/zip_info', methods = ['GET'])
def zip_info_route():
	zip_info = db.session.query(Zip.zip_code, Zip.city).all()
	return render_template('table_zip.html', content = zip_info)

@app.route('/bank', methods = ['GET'])
def bank_route():
	bank_info = db.session.query(Bank.vtal, Bank.name, Bank.balance, Bank.equity, Bank.email, Bank.phone_number, Bank.street_name, Bank.street_number, Bank.zip_code).all()
	return render_template('table_bank.html', content = bank_info)

@app.route('/login', methods = ['GET', 'POST'])
def login_route():
	if request.method == 'POST':
		try:
			username = str(Customerlogin(request.form['username']))
			logins = db.session.query(Customerlogin.username, Customerlogin.customer_id).all()
			for login in logins:
				if username == str(login[0]):
					customer_id = int(login[1])
					print(customer_id)
					customer_info = db.session.query(Customer.customer_id, Customer.creation_date, Customer.ptal).filter(Customer.customer_id == customer_id).all()[0]
					ptal = customer_info[2]
					person_info = db.session.\
					query(Person.first_name, Person.middle_name, Person.last_name,\
						Person.street_name, Person.street_number, Person.email, Person.phone_number,\
						Person.zip_code).filter(Person.ptal == ptal).all()[0]
					print(person_info)
					zip_info = db.session.query(Zip.city).filter(Zip.zip_code == person_info[7]).all()[0][0]
					print(zip_info)
					return render_template('logged_in.html', name = username, customer = customer_info, person = person_info, zip = zip_info)
			return redirect(url_for('login_route'))
		except (Exception) as e:
			print(e)
			return redirect(url_for('index'))
	else:
		return render_template('index.html', login = True)

@app.route('/customer/<ptal>')
def customer_route(ptal):
	try:
		person_info = db.session.query(Person.first_name, Person.middle_name, Person.last_name,\
			Person.street_name, Person.street_number, Person.email, Person.phone_number, Person.zip_code)\
				.filter(Person.ptal == ptal).all()[0]
		customer_info = db.session.query(Customer.customer_id, Customer.creation_date, Customer.ptal).filter(Customer.ptal == ptal).all()[0]
		zip_info = db.session.query(Zip.city).filter(Zip.zip_code == person_info[7]).all()[0][0]
		return render_template('customer.html', person = person_info, customer = customer_info, zip = zip_info)
	except (Exception) as e:
		print(e)
		return redirect(url_for('index'))

@app.route('/accounts/<ptal>')
def account_route(ptal):
	try:
		person_info = db.session.query(Person.first_name, Person.middle_name, Person.last_name,\
			Person.street_name, Person.street_number, Person.email, Person.phone_number, Person.zip_code)\
				.filter(Person.ptal == ptal).all()[0]
		customer_info = db.session.query(Customer.customer_id, Customer.creation_date, Customer.ptal).filter(Customer.ptal == ptal).all()[0]
		zip_info = db.session.query(Zip.city).filter(Zip.zip_code == person_info[7]).all()[0][0]
		account_info = db.session.query(Account.account_id, Account.balance, Account.account_type, Account.creation_date, Account.customer_id).filter(Account.customer_id == customer_info[0]).all()
		accounttype = account_info[0][2]
		accounttype_info = db.session.query(Accounttype.type_name, Accounttype.account_type).filter(Accounttype.account_type == accounttype).all()
		return render_template('accounts.html', person = person_info, customer = customer_info, zip = zip_info, account = account_info, accounttype = accounttype_info)
	except (Exception) as e:
		print(e)
		return redirect(url_for('index'))

@app.route('/transactions/<ptal>')
def transactions_route(ptal):
	try:
		person_info = db.session.query(Person.first_name, Person.middle_name, Person.last_name,\
			Person.street_name, Person.street_number, Person.email, Person.phone_number, Person.zip_code)\
				.filter(Person.ptal == ptal).all()[0]
		customer_info = db.session.query(Customer.customer_id, Customer.creation_date, Customer.ptal).filter(Customer.ptal == ptal).all()[0]
		zip_info = db.session.query(Zip.city).filter(Zip.zip_code == person_info[7]).all()[0][0]
		return render_template('transaction.html', person = person_info, customer = customer_info, zip = zip_info)
	except (Exception) as e:
		print(e)
		return redirect(url_for('index'))

@app.route('/customerlogin_info', methods = ['GET'])
def login_info_route():
	login_info = db.session.query(Customerlogin.username, Customerlogin.customer_id).all()
	return render_template('table_customerlogin.html', content = login_info)

@app.route('/customer_info', methods = ['GET'])
def customer_info_route():
	customer_info = db.session.query(Customer.customer_id, Customer.creation_date, Customer.ptal).all()
	return render_template('table_customer.html', content = customer_info)

@app.route('/person_info', methods = ['GET'])
def person_info_route():
	person_info = db.session.query(Person.ptal, Person.first_name, Person.middle_name, Person.last_name,\
			Person.street_name, Person.street_number, Person.email, Person.phone_number, Person.zip_code).all()
	return render_template('table_person.html', content = person_info)

@app.route('/accounttype_info', methods = ['GET'])
def accounttype_info_route():
	#accounttype_info = db.session.query(AccountType.name, AccountType.rent).all()
	accounttype_info = db.session.query(Accounttype.account_type, Accounttype.name, Accounttype.rent).all()
	return render_template('table_accounttype.html', content = accounttype_info)

@app.route('/post_zip', methods = ['POST'])
def post_zip_route():
	try:
		zip_code = Zip(request.form['zip'], request.form['city'])
		db.session.add(zip_code)
		db.session.commit()
	except (Exception) as e:
		print(e)
	finally:
		return redirect(url_for('index'))

# Set HTTP port
if __name__ == '__main__':
	app.run(host='0.0.0.0', port=80, debug=True)
