{% extends 'bootstrap/base.html' %}
{% block title %}
	Consultar
{% endblock %}
{% block styles%}
	


	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
	<div class="alert alert-success" style="margin-right: 630px;">
  		<strong>Clique <a href="/pedidos/consultar" class="alert-link">aqui</a>(ou no botao abaixo), para visualizar sua lista de pedidos anteriores e consultá-los também. </strong>
	</div>
	<h1>Consulta de pedido</h1>
		
	<table class="table table-hover table-responsive">
		<thead>
			<th>Pago</th>
			<th>Liberado</th>
			<th>Entregue</th>
		</thead>
		<tbody>
			
			<tr>
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
						
			</tr>
		
		</tbody>
	</table>
	
	<a class="btn btn-info" href="/pedidos/consultar">
  		Voltar
	</a>


{% endblock %}