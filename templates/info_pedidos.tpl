{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block content %}

	 <h1 style="text-align: center;">Informações do seu pedido</h1>
	<table class="table table-hover table-responsive">
		<tbody>
			<tr class="active">
				<th>Número do pedido</th>

				<th>Preço unitário</th>

				<th>Quantidade</th>

				<th>Total</th>

				<th>Nome do produto</th>
			</tr>
		</tbody>
	
	{% if request.method == 'POST' %}
	<tbody>
		{% for i in tamanho %}
			<tr class="info">
				<td>{{ ped_id }}</td>
				<td>{{ dados[i][2] }}</td>
				<td>{{ dados[i][3] }}</td>
				<td>{{ dados[i][4] }}</td>
				<td>{{ dados[i][5] }}</td>
			</tr>
		{% endfor %}
	</tbody>
	{% endif %}
	</table>
	
	<table border="solid" style="margin-left: 165px;float: left; margin-top: -30px;">
		
	</table>
	
	<a class="btn btn-success" href="consultar2/{{ped_id}}">
  		Consultar pedido
	</a>
	
	

	<!--
	<a href="/pedidos/fazer">
	<input type="submit" value="Voltar">
	</a>
	<input type="submit" value="Confirmar compra">
	-->
{% endblock %}