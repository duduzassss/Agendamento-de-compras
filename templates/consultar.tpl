{% extends 'bootstrap/base.html' %}
{% block title %}
	Consulte seu pedido
{% endblock %}
{% block styles%}
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">


	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}

	<style type="text/css">
		.numPed,.total,.dataPed,.agend,.dataRen,.pag,.lib,.entr{
			color: white;
			text-align: center;
		}
		td{
			text-align: center;
		}
		.rosa,.cinz{
			text-align: left;
		}
		h1{
			margin-left: 15px;
		}
		
	</style>
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
		
		<h1>Consulta de pedido</h1>
		
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
		<div class="col-md-12">
		<table class="table table-hover table-responsive">
			<tr class="bg-dark table-bordered">
				<th class="numPed">Nº do pedido</th>
				<th class="total">Total R$</th>
				<th class="dataPed">Data do Pedido</th>
				<th class="agend">A cada dia [ ] do mês</th>
				<th class="dataRen">Data Renovação (dia,mês)</th>
				<th class="pag">Pago</th>
				<th class="lib">Liberado</th>
				<th class="entr">Entregue</th>
				

			</tr>
			<tbody>
				{% for dado in dados %}
				<tr class="table-bordered">					
						<td class="_id table-active">{{dado.id}}</td>
						<td class="table-active">{{dado.total}}</td>
						<td class="table-active">{{dado.data.strftime('%d/%m/%Y')}}</td>
						<td class="table-active">{{dado.data_agendamento}}</td>
						<td class="table-active">{{dado.data_renovacao()}}</td>
						<td class="table-active">
						<input type="checkbox" onclick="return false;" name="pago" 
							{% if dado.pago == True %}
								checked
							{% endif %}/>
						</td>
						<td class="table-active">
						<input type="checkbox" onclick="return false;" name="liberado_entrega" 
							{% if dado.liberado_entrega == True %}
								checked
							{% endif %}/>
						</td>
						<td class="table-active">
						<input type="checkbox" onclick="return false;" name="entregue" 
							{% if dado.entregue == True %}
								checked
							{% endif %}/>
						</td>
						<td>
							<a class="btn btn-danger" href="/pedidos/del/{{dado.id}}">
	  				 			Deletar Pedido
							</a>
						</td>
						<td>
							<a class="btn btn-info" href="/mais-informacoes/{{dado.id}}">
								Mais informações
							</a>
						</td>

						<input type="hidden" name="id" value="{{dado.id}}">
					
					
				</tr>

				{% endfor %}
			</tbody>
		</table>
	</div>

		
	</div>
{% endblock %}