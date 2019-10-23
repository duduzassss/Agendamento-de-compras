{% extends 'bootstrap/base.html' %}
{% block title %}
	Pedidos
{% endblock %}
{% block styles%}
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}

	<h1>Atualização de pedido</h1>
	<form action="{{url_for('post_atupedido')}}" method="POST">
		<input type="hidden" name="id" value="{{dado.id}}">
	<table class="table table-hover table-responsive">
		<tr>
			<th>Pago</th>
			<th>Liberado</th>
			<th>Entregue</th>
		</tr>
		<tbody>
		
			<tr>
				<td>
					<input type="checkbox" name="pago" style="margin-left: 25%;" 
					{% if dado.pago ==1 %}
						checked
					{% endif %}
					>
				</td>
				<td>
					<input type="checkbox" name="liberado_entrega" style="margin-left: 40%;" 
					{% if dado.liberado_entrega ==1 %}
						checked
					{% endif %}>
				</td>
				<td>
					<input type="checkbox" name="entregue" style="margin-left: 40%;" 
					{% if dado.entregue ==1 %}
						checked
					{% endif %} 
					>
				</td>
				<td>
					<input class="btn btn-success" type="submit" name="submit" value="Gravar">

					<a href="/pedidos" class="btn btn-info">Voltar</a>
				</td>
			</tr>
		
		</tbody>
	</table>
</form>

{% endblock %}