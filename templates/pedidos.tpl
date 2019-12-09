{% extends "base.tpl" %}
{% block title %}
	Pedidos
{% endblock %}
{% block scripts %}
	{{super()}}
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!--<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->
	<script src="{{ url_for('static', filename='js/bootstrap.min.js')}}"></script>

{% endblock %}
{% block styles%}
	
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}

	<style type="text/css">
		#cabecalho{
			color: white;
		}
	</style>
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
		
		<h1 style="margin-left: 15px;">Pedidos</h1>
		{% with messages = get_flashed_messages(with_categories=true) %}
		  {% if messages %}
		    <ul class="flashes">
		    {% for category, message in messages %}
		      <li class="alert alert-{{ category }}">{{ message }}</li>
		    {% endfor %}
		    </ul>
		  {% endif %}
		{% endwith %}
		<a class="btn btn-success" href="/pedidos/fazer" style="margin-left: 15px;">Faça seu pedido</a><br/><br/>
		
		
		<div>
		<div class="col-md-12">
	      <form action="{{url_for('ins_get_pedidos1')}}" method="POST">
	        <h4>
	          Data inicial <input type="date" name="dataIni">
	          Data Final <input type="date" name="dataFim">
	        </h4>
	        <button class="btn btn-primary" type="submit">Aplicar filtro</button>
	      </form>
		<table class="table table-hover table-responsive">
			<tr id="cabecalho" class="bg-dark table-bordered">
				<th style="text-align: center;">Nº do pedido</th>
				<th style="text-align: center;">Total R$</th>
				<th style="text-align: center;">Data do Pedido</th>
				<th style="text-align: center;">A cada dia [ ] do mês</th>
				<th style="text-align: center;">Data Renovação (dia, mes)</th>
				
			</tr>
			<tbody>
				{% for dado in dados %}
					<tr class="table-bordered">
						<td class="_id table-success" style="text-align: center;">{{dado.id}}</td>
						<td style="text-align: center;" class="table-success">{{dado.total}}</td>
						<td style="text-align: center;" class="table-success">{{dado.data.strftime('%d/%m/%Y')}}</td>
						<td style="text-align: center;" class="table-success">{{dado.data_agendamento}}</td>
						<td style="text-align: center;" class="table-success">{{dado.data_renovacao()}}</td>
						<td>
							<a class="btn btn-success" href="/atupedido/{{dado.id}}">
	  				 			Atualizar
							</a>
						</td>
						<td>
							<a class="btn btn-info" href="/renovar-pedido/{{dado.id}}">
	  				 			Renovar Pedido
							</a>
						</td>
						<td>
							<a class="btn btn-warning" href="/pedidos/del/{{dado.id}}">
	  				 			Deletar Pedido
							</a>
						</td>
						<td>
							<a class="btn btn-danger" href="/relatorio/{{dado.id}}">
								Relatório
							</a>
						</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
	</div>

		
	</div>
		
{% endblock %}