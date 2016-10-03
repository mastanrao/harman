
ad bootstrap3 %}
  <head>
    <link rel="stylesheet" href="http://v4-alpha.getbootstrap.com/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous">
    </script>
    <script>window.jQuery || document.write('<script src="/assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="http://v4-alpha.getbootstrap.com/dist/js/bootstrap.min.js"></script>
    <script src="http://jonthornton.github.io/jquery-timepicker/jquery.timepicker.js"></script>
    <link rel="stylesheet" href="http://jonthornton.github.io/jquery-timepicker/jquery.timepicker.css">
    <style>
        .reserved {
                background-color: #d2d2d2;
        }

        /* sizes */
        .business-area > div {
            min-height: 450px;
        }

        .business-area > div { min-height: 450px; }

        /* layout */
        .business-area {
            /* overflow to handle inner floating block */
            padding: 0 10%;
            overflow: hidden;
        }

        .reserved {
            float: right;
            width: 30%;
        }

        .top-buffer {
            margin-top:20px;
            background-color: #d2d2d2;
        }

        .time-bar {
            background-color: #d2d2d2;
        }
        .content {
            min-height: 200px;
        }

        .title {
            color: #FFFFFF;
            background-color: #3b5998;
        }

        .errors {
            display: none;
        }

        .errors li {
            color: #FF0000;
        }

        input[type=submit] {
            display: none;
        }

        .pull-right {
            float: right;
        }
    </style>
  </head>

  <!-- Modal -->
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h4 class="modal-title" id="myModalLabel">Submit Schedule</h4>
        </div>
      <div class="modal-body">
        <div class="errors"> Errors</div>
          {% bootstrap_form form %}
          <input type="submit" value="Submit" />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" id="submit_schedule">Submit</button>
        </div>
      </div>
    </div>
  </div>

  <div>
    <div class="business-area">
      <div class="wall">
        <div class="container">
          <pre>

          </pre>

          {% if login_requred %}
              <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                  Register
              </button>

          {% else %}

          {% for schedule in schedules %}
          <div class="row top-buffer">
            <div class="col-md-12 title">
              <p class="title">
                <h2>
                  {{schedule.title}}
                </h2>

              <small class="pull-right">Scheduled by: {{schedule.scheduled_by}}</small>
            </p>
          </div>
          <div class="col-md-12">
            <div class="col-md-3 time-bar">
              <br>
              <p class="calendar">
                Start: {{schedule.start_date}} <em> - {{schedule.start_time}}</em>
              </p>
              <p>
                End:   {{schedule.end_date}} <em> - {{schedule.end_time}}</em>
              </p>
            </div><!--./col-md-->
    
            <div class="col-md-9 content">
              <p>
                {{schedule.description}}
              </p>
            </div><!--/. col-md -->
          </div>
        </div><!--/row-->
        {% endfor %}
        {% endif %}
        <pre>

        </pre>
      </div>
    </div>
    </div>
  </div>

  <script>
      $('#submit_schedule').on('click', function(e){
        $('.errors').empty();
        $('.errors').css('display','none');
        var data = {
          'title': document.getElementById("id_title").value,
          'description': document.getElementById("id_description").value,
          'start_date': document.getElementById("id_start_date").value,
          'start_time': document.getElementById("id_start_time").value,
          'end_date': document.getElementById("id_end_date").value,
          'end_time': document.getElementById("id_end_time").value,
          'scheduled_by': document.getElementById("id_scheduled_by").value
        }
        $.ajax({
          type: "POST",
          url: "/submit_schedule/",
          data: data,
          success: function(response) {
              if (response.success) {
                  $('#myModal').modal('hide');
                  window.location.reload();
              } else {
                  $.each(response.errors, function (key, value) {
                    $(".errors")
                      .append($("<li></li>")
                      .attr("value", key)
                      .text(key + ' : ' + value));
                  });
                  $('.errors').css('display','block');
              }
          }
        });
      });

      $('#id_start_time').timepicker({timeFormat: 'HH'});
      $
  </script>
</html>
