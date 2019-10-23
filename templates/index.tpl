<!doctype html>
<html lang="pt-br">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Pagina Inicial - Agendamento de compras</title>

    <!-- Bootstrap core CSS -->
    <link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">


    <style type="text/css">
      .container p a{
        float: left;
        margin-right: 10px;
      }
    </style>
  </head>

  <body>
    
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
      <a class="navbar-brand" href="/" style="font-style: italic; font-weight: bolder;">Shopping Schedule</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          
          <li class="nav-item active">
            <a class="nav-link" href="pedidos">Pedidos<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="produtos">Produtos<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="usuario">Usuarios<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="/pedidos/consultar">Consultar compras<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="/favoritar">Favoritos<span class="sr-only">(current)</span></a>
          </li>
          {% if current_user.is_anonymous %}
            <li class="nav-item active">
              <a class="nav-link" href="login">Entrar <span class="sr-only">(current)</span></a>
            </li>
          {% endif %}
          {% if current_user.is_anonymous %}
            <li class="nav-item active">
              <a class="nav-link" href="register">Registrar-se <span class="sr-only">(current)</span></a>
            </li>
          {% endif %}
          {% if current_user.is_authenticated %}
            <li class="nav-item active">
              <a class="nav-link" href="logout">Sair <span class="sr-only">(current)</span></a>
            </li>
          {% endif %}
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Pesquise aqui..." aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Pesquisar</button>
        </form>
      </div>
    </nav>

    <main role="main">

      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <div class="container">
          <h1 class="display-3">Bem-vindo(a) <editname style="text-transform: capitalize;">{{ current_user.username }}</editname>!</h1>
          <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
          <p><a class="btn btn-success btn-lg" href="login" role="button">Entrar &raquo;</a></p>
          <p><a class="btn btn-primary btn-lg" href="register" role="button">Registrar-se &raquo;</a></p>
        </div>
      </div>

      <div class="container">
        <!-- Example row of columns -->
        <div class="row">
          <div class="col-md-4">
            <h2>Sobre nós</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
            <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
          </div>
          <div class="col-md-4">
            <h2>Localização</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
            <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
          </div>
          <div class="col-md-4">
            <h2>Contato</h2>
            <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
            <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
          </div>
        </div>

        <hr>

      </div> <!-- /container -->

    </main>

    <footer class="container">
      <p>&copy; Todos os direitos autorais reservados - 2019</p>
    </footer>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    
    <script src="{{ url_for('static', filename='js/bootstrap.min.js')}}"></script>
  </body>
</html>
