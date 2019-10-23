{% extends 'bootstrap/base.html' %}
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

	<!--<script type="text/javascript">
		$(document).ready(function(){
			$('.checkbox').click(function() {
				//var formData = $('#myForm').serialize();
				//console.log('Bla bla:', formData);
			/*$(this).trigger('click'); */
			let values1 = 0;
			/* $('table tr td :checkbox:checked').map(function () {
                return $(this).closest('tr').find('td:first').text()});		 */
            
			$.ajax({
				data: {
					/*pago: $(this).attr('input[name="pago"]'),*/
					pago: $(this).is(':checked'),
					id: values1
					/* $(this).find('._id' ).val() */
				},
				method:'POST',
				url:'http://localhost:7000/atupagamento'
			})
			.done(function(data){
				if (data.error) {
					$('#errorAlert').text(data.error).show();
					$('#successAlert').hide();
				}
				else {
					$('successAlert').text(data.pago).show();
					$('errorAlert').hide();
				}
			})
			.fail(function(data){
				alert("falhou");
			});

	});
			
		});
	</script>-->

{% endblock %}
{% block styles%}
	
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
	{{super()}}
{% endblock %}
{% block content %}
{% include 'menu_superior.tpl' %}
		
		<h1>Pedidos</h1>
		{% with messages = get_flashed_messages(with_categories=true) %}
		  {% if messages %}
		    <ul class="flashes">
		    {% for category, message in messages %}
		      <li class="alert alert-{{ category }}">{{ message }}</li>
		    {% endfor %}
		    </ul>
		  {% endif %}
		{% endwith %}
		<a class="btn btn-success" href="/pedidos/fazer">Faça seu pedido</a><br/><br/>
		
		<form action="" method="POST" id="myForm">
		<table class="table table-hover table-responsive">
			<tr>
				<th>Nº do pedido</th>
				<th>Total R$</th>
				<th>Data</th>
				<th>Atualizar</th>
			</tr>
			<tbody>
				{% for dado in dados %}
				<tr>
					<td class="_id">{{dado.id}}</td>
					<td>{{dado.total}}</td>
					<td>{{dado.data}}</td>
					<td>
						<a class="btn btn-warning" href="/atupedido/{{dado.id}}">
  				 			Atualizar
						</a>
					</td>
					<!--<input type="hidden" name="id" value="{{dado.id}}">-->

					

				</tr>

				{% endfor %}
			</tbody>
		</table>
		</form>
{% endblock %}