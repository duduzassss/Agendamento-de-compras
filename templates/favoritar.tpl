{% extends 'bootstrap/base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}
{% block title %}
	Listagem de favoritos
{% endblock %}
{% block styles %}
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap core CSS -->
<link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=El+Messiri&display=swap" rel="stylesheet">
<style type="text/css">
	.subtitulo{
		font-size: 17px;
		text-indent: 10px;
		font-family: 'El Messiri', sans-serif;

	}
	.titulo{
		font-family: 'El Messiri', sans-serif;
 
	}
</style>
{{super()}}
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
	
	{% with messages = get_flashed_messages(with_categories=true) %}
	  {% if messages %}
	    <ul class="flashes" style="list-style: none; margin-left:-40px; text-align: center; font-size: 20px;">
	    {% for category, message in messages %}
	      <li class="alert alert-success">{{ message }}</li>
	    {% endfor %}
	    </ul>
	  {% endif %}
	{% endwith %}


	<h1 class="titulo">Favoritos</h1>
	<p class="subtitulo">Escolha os produtos que desejar, para uma proxima compra.</p>
	<form action="{{url_for('post_fav')}}" method="POST">
	<div>
	<div class="col-md-8">
	<table class="table table-stripped">
		<tr>
			<th>Produtos</th>
		</tr>
		{% for produto in produtos %}
		<tr>
			<td>
				{% if produto.id in dados %}
					<input type="checkbox" name="produto" value="{{produto.id}}" checked />
					{{ produto.nome_produto }}

					
				{% else %}
					<input type="checkbox" name="produto" value="{{produto.id}}"/>
					{{ produto.nome_produto}}

					
				{% endif %}

			</td>
			<td>
				
			</td>
		</tr>
		{% endfor %}

	</table>
</div>
	
	<div class="col-md-8">
	

	<input type="submit" value="Favoritar" class="btn btn-success">
</div>
</div>
</form>
{% endblock %}