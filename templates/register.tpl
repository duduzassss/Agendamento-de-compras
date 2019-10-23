{% extends 'bootstrap/base.html'%}
{%import 'bootstrap/wtf.html' as wtf%}

{% block styles%}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}

{% block title %}
	Login
{% endblock %}

{% block scripts %}
	{{super()}}
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
	<script src="{{ url_for('static', filename='js/bootstrap.min.js')}}"></script>
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
<h1>Register</h1>
{{ wtf.quick_form(form) }}
{%endblock%}