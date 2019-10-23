{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block title %}
	Inserir Informações
{% endblock %}
{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
	 <h1>Inserir</h1>
	
		{{wtf.quick_form(form, action=url_for('ins_post_usuario'))}}
	

{% endblock %}