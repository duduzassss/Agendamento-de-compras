{% extends 'bootstrap/base.html' %}
{% block title %}
	Visualizar Produtos
{% endblock %}

{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
	
	 <h1>Visualizar</h1>
		<form method="GET" action="/produtos" >
			<p>Nome do Produto: {{dados.nome_produto}}</p>
			<p>Valor: {{dados.valor}}</p>
			<input type="submit" value="Voltar" />
		</form>
{% endblock %}