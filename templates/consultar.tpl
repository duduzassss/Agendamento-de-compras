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
		
		
		<table class="table table-hover table-responsive">
			<tr>
				<th>Nº do pedido</th>
				<th>Total R$</th>
				<th>Data</th>
				<th>Pago</th>
				<th>Liberado</th>
				<th>Entregue</th>
				<th>Consultar</th>
				
			</tr>
			<tbody>
				{% for dado in dados %}
				<tr>
					<td class="_id">{{dado.id}}</td>
					<td>{{dado.total}}</td>
					<td>{{dado.data}}</td>
					<td>
					<input type="checkbox" onclick="return false;" name="pago" 
						{% if dado.pago == True %}
							checked
						{% endif %}/>
					</td>
					<td>
					<input type="checkbox" onclick="return false;" name="liberado_entrega" 
						{% if dado.liberado_entrega == True %}
							checked
						{% endif %}/>
					</td>
					<td>
					<input type="checkbox" onclick="return false;" name="entregue" 
						{% if dado.entregue == True %}
							checked
						{% endif %}/>
					</td>
					<td>
						<a class="btn btn-info" href="consultar2/{{dado.id}}">
  				 			Consultar
						</a>
					</td>
					

					<input type="hidden" name="id" value="{{dado.id}}">

					

				</tr>

				{% endfor %}
			</tbody>
		</table>
{% endblock %}