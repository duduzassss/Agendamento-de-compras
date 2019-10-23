{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block styles %}
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}

{% block title %}
	Editar Informações
{% endblock %}

{% block content %}
{% include 'menu_superior.tpl' %}
	 
	 	<div class="alert alert-danger" style="font-weight: bolder;">Lembrete: É necessário preencher todos os campos para conseguir atualizar os dados.</div>

	 	<div class="alert alert-primary" style="font-weight: bolder;">Caso seja de sua preferência editar apenas um campo(ou mais), estaremos deixando uma lista das suas informações.<pre style="width: 350px;">
Telefone:{{dado.telefone}}
Endereço:{{dado.endereco}}
Cartão:{{dado.cartao}}
CPF:{{dado.cpf}}</pre>
	 	</div>
	 	<h1>EDITAR</h1>
		<form method="POST" action="/usuario/edit/{{dado.id}}">
		{{form.hidden_tag()}}
			<b><p>Telefone:
		    {{form.telefone}}
		    </p></b>
		    <b><p>Endereço:
		    {{form.endereco}}
		    </p></b>
		   <b><p>Cartão:
		   	{{form.cartao}}
		    </p></b>
		   <b><p>CPF:
		    {{form.cpf}}
		    </p></b>
    		<input class="btn btn-success" type="submit" value="Atualizar dados">

    		<a class="btn btn-info" href="/usuario">
  		Voltar
	</a>
  		</form>

{% endblock %}