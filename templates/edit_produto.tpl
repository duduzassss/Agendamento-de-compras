{% extends 'bootstrap/base.html' %}
{% block title %}
	Editar Produtos
{% endblock %}

{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}

	 <h1>Editar</h1>	
		<form method="POST" action="/produtos/edit/{{dado.id}}">
		{{form.hidden_tag()}}
			<div class="alert alert-primary"><strong>Você está editando o produto:</strong> <strong style="color: black; text-transform: uppercase;">{{dado.nome_produto}}</strong> </div>

		    <p>Valor:
		    {{form.valor}}
		    
		    </p>
		<!--
		    <p>Quantidade:
		   	{{form.quantidade}}
		    </p>
		-->
    		<input type="submit" value="Atualizar dados">
  		</form>
{% endblock %}