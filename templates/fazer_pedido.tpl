{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block title %}
	Fazer Pedido
{% endblock %}
{% block styles %}
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap core CSS -->
<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
{{super()}}

<style type="text/css">
	h1{
		margin-left: 15px;
	}
</style>
{% endblock %}
{% block scripts %}
{{super()}}
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="{{ url_for('static', filename='js/bootstrap.min.js')}}"></script>
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
	<h1>Faça seu pedido</h1>
	<form action="{{url_for('ins_get_pedidos3')}}" method="POST">
	<div>
	<div class="col-md-8">
	<table class="table table-stripped">
		<tr>
			<th>Produtos</th>
		</tr>
		{% for dado in dados %}
		  <tr>
		   <td>
		    {% if dado.id in idsFav %}
		        <input type="checkbox" name="produto" value="{{dado.id}}" checked/>
		    {% else %}
		        <input type="checkbox" name="produto" value="{{dado.id}}"/>
		    {% endif %}
		     {{ dado.nome_produto }}
		   </td>
		  </tr>
		{% endfor %}
	</table>
</div>
	
	<div class="col-md-4">
	<table class="table table-stripped">
		<tr>
			<th style="text-align: center;">Pagamento</th>
		</tr>
		<tr>
			<td>
				<input type="radio">
				Cartão de crédito
			</td>
		</tr>
	</table>

	<div class="col-md-12">
	<table class="table table-stripped">
		<tr>
			<th style="text-align: center;">Deseja agendar para uma próxima compra?</th>
		</tr>
		<tr>
			<td>
				A cada dia 
				<input type="number" value="1" min="1" max="31" name="agendamento" style="width: 40px;">
				do próximo mês.
			</td>
		</tr>
	</table>
	</div>
	<a href="/pedidos" class="btn btn-info">Voltar</a>

	<input type="submit" value="Avançar" class="btn btn-success">
</div>
</div>
</form>
{% endblock %}