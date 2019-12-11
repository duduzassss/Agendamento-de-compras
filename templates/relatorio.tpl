{% extends 'bootstrap/base.html' %}
{% block title %}
	Relatório do pedido
{% endblock %}
{% block styles%}
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

	<!--Letras-->
	<link href="https://fonts.googleapis.com/css?family=Noto+Serif&display=swap" rel="stylesheet">

	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}

	<style type="text/css">
		.nome,.ende,.num,.prod,.quant,.valor,.total,.data,.idPed,.nomeprod{
			color: white;
		}
		h1{
			font-family: 'Noto Serif', serif;
			margin-left: 15px;
		}
		h4{
			margin-bottom: 20px;
		}
		dinheiro{
			font-size: 35px;
			color:green;
			font-weight: bold;
		}
		rs{
			color: green;
			font-weight: bold;
		}
	</style>
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
		
		<h1>Relatório do Pedido</h1>
		{% with messages = get_flashed_messages(with_categories=true) %}
		  {% if messages %}
		    <ul class="flashes">
		    {% for category, message in messages %}
		      <li class="alert alert-{{ category }}">{{ message }}</li>
		    {% endfor %}
		    </ul>
		  {% endif %}
		{% endwith %}

		<div>
		<div class="col-md-9">
			<h4><strong>Nome do cliente:</strong> {{dadostpl[0][0]}}</h4>
			<h4><strong>Endereço:</strong> {{dadostpl[0][1]}}</h4>
			<h4><strong>Data do pedido:</strong> {{dadostpl[0][2]}}</h4>
			<h4><strong>Total a pagar:</strong> <rs>R$</rs><dinheiro>{{dadostpl[0][8]}}</dinheiro></h4>
		<table class="table table-hover table-responsive">
			<tr class="bg-dark table-bordered">
				<th class="quant">Quantidade</th>
				<th class="total">Total</th>
				<th class="nomeprod">Nome produto</th>
				
				<th class="idPed">ID do pedido</th>
				
				
			</tr>


			<tbody>

				{% for dado in dadostpl %}
				<tr class="table-bordered">
						
						<td class="table-danger">{{ dado[3] }}</td>
						<td class="table-danger">{{ dado[4] }}</td>
						<td class="table-danger">{{ dado[5] }}</td>
				
						<td class="table-danger">{{ dado[7] }}</td>

						<input type="hidden" name="id" value="{{dado.id}}">
					
					
				</tr>

				{% endfor %}
			</tbody>
		</table>
		<a class="btn btn-info" href="/pedidos" style="font-weight: bold;">
				Retornar para lista de pedidos
		</a>
	</div>

		
	</div>

{% endblock %}