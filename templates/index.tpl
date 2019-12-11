<!doctype html>
<html lang="pt-br">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Pagina Inicial - Agendamento de compras</title>
    <!--Google Fonts-->
    <link href="https://fonts.googleapis.com/css?family=Noto+Serif&display=swap" rel="stylesheet">


    <!-- Bootstrap core CSS -->
    <link href="{{ url_for('static', filename='css/bootstrap.min.css')}}" rel="stylesheet">


    <style type="text/css">
      .container p a{
        float: left;
        margin-right: 10px;
      }
      h1,h2{
        font-family: 'Noto Serif', serif;

      }
      main{
        margin-bottom: 75px;
      }
      .jumbotron{
        background-color: #A9DEF9;
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
          
          {% if current_user.is_authenticated and current_user.is_administrator() %}
            <li class="nav-item active">
              <a class="nav-link" href="pedidos">Pedidos<span class="sr-only">(current)</span></a>
            </li>
          {% else %}
            <li class="nav-item active">
              <a class="nav-link" href="/pedidos/fazer">Fazer pedido<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

          {% if current_user.is_authenticated and current_user.is_administrator() %}
            <li class="nav-item active">
              <a class="nav-link" href="produtos">Produtos<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

          {% if current_user.is_authenticated and current_user.is_administrator() %}
          <li class="nav-item active">
            <a class="nav-link" href="usuario">Usuarios<span class="sr-only">(current)</span></a>
          </li>
          {% else %}
          <li class="nav-item active">
            <a class="nav-link" href="usuario">Perfil<span class="sr-only">(current)</span></a>
          </li>
          {% endif %}
          
          {% if current_user.is_authenticated and current_user.is_administrator() %}
          {% else %}
            <li class="nav-item active">
            <a class="nav-link" href="/pedidos/consultar">Consultar pedidos<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

          {% if current_user.is_authenticated and current_user.is_administrator() %}
          {% else %}
            <li class="nav-item active">
              <a class="nav-link" href="/favoritar">Favoritos<span class="sr-only">(current)</span></a>
            </li>
          {% endif %}

        </ul>
        <form class="form-inline my-2 my-lg-0">
        <ul class="navbar-nav mr-auto">
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
        </form>
      </div>
    </nav>

    <main role="main">

      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <div class="container">
          {% with messages = get_flashed_messages(with_categories=true) %}
            {% if messages %}
              <ul class="flashes" style="list-style: none; margin-left:-40px; text-align: center; font-size: 20px;">
              {% for category, message in messages %}
                <li class="alert alert-success">{{ message }}</li>
              {% endfor %}
              </ul>
            {% endif %}
          {% endwith %}
          <h1 class="display-3 nome">Bem-vindo(a) <editname style="text-transform: capitalize;">{{ current_user.username }}</editname>!</h1>
          <p>Técnologia à serviço da população. Faça seu pedido com segurança e praticidade, no corforto do seu lar. Ao utilizar nossos serviços, voce terá como realizar pedidos, cadastrar produtos, cadastrar usuários, consultar pedidos, favoritar produtos prediletos, gerar relatório, filtrar pedidos, agendar pedidos, entre outras funcionalidades que virão por ai.</p>
          
          {% if current_user.is_authenticated %}
          {% else %}
            <p><a class="btn btn-success btn-lg" href="login" role="button">Entrar &raquo;</a></p>
            <p><a class="btn btn-primary btn-lg" href="register" role="button">Registrar-se &raquo;</a></p>
          {% endif %}
        </div>
      </div>

      <div class="container">
        <!-- Example row of columns -->
        <div class="row">
          <div class="col-md-4">
            {% if current_user.is_authenticated and current_user.is_administrator() %}
              <h2>Pedidos</h2>
              <p>Gerencie, analise, atualize, entre outras funcionalidades do software, os pedidos de seus clientes.</p>
              <p><a class="btn btn-primary" href="/pedidos" role="button">Gerenciar Pedidos &raquo;</a></p>
            {% else %}
              <h2>Perfil</h2>
              <p>Complete as informações do  seu perfil clicando no botao abaixo, para conseguir fazer suas compras.</p>
              {% if current_user.is_authenticated %}
                <p><a class="btn btn-primary" href="/perfil/{{ current_user.id }}" role="button">Ir para Perfil &raquo;</a></p>
              {% else %}
                <p><a class="btn btn-primary" href="/login" role="button">Ir para Perfil &raquo;</a></p>
            {% endif %}
            {% endif %}
          </div>

          <div class="col-md-4">
            {% if current_user.is_authenticated and current_user.is_administrator() %}
              <h2>Produtos</h2>
              <p>Registre seus produtos de forma simples, rápida e prática, para começar a vende-los e gerar lucros.</p>
              <p><a class="btn btn-primary" href="/produtos/ins" role="button">Adicionar um Produto &raquo;</a></p>
            {% else %}
              <h2>Faça seu pedido</h2>
              <p>Realize seu pedido e tenha os melhores produtos e com alta qualidade, clique no botao abaixo e complete seu pedido.</p>
              <p><a class="btn btn-primary" href="/pedidos/fazer" role="button">Fazer Pedido &raquo;</a></p>
            {% endif %}
          </div>

          <div class="col-md-4">
            {% if current_user.is_authenticated and current_user.is_administrator() %}
              <h2>Usuários</h2>
              <p>Visualize seus clientes cadastrados no sistema, e verifique se não há pendências em seus cadastros.</p>
              <p><a class="btn btn-primary" href="/usuario" role="button">Ir para lista de usuários &raquo;</a></p>
            {% else %}
              <h2>Favorite</h2>
              <p>Faça dos seus produtos prediletos, os seus favoritos, para agilizar o processo uma próxima compra.</p>
              <p><a class="btn btn-primary" href="/favoritar" role="button">Escolher Produtos &raquo;</a></p>
            {% endif %}
          </div>
        </div>

        <hr>

      </div> <!-- /container -->

    </main>


    <footer class="container" style="text-align: center; font-size: 18px;">
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
