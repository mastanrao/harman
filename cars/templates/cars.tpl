<html>
  {% load bootstrap3 %}
  <head>
    <link rel="stylesheet" href="http://v4-alpha.getbootstrap.com/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous">
    </script>
    
    <script src="http://v4-alpha.getbootstrap.com/dist/js/bootstrap.min.js"></script>
    
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

        .message {
            display: none;
        }

        .message li {
            color: green;
        }

        input[type=submit] {
            display: none;
        }

        .pull-right {
            float: right;
        }

        .login_required {
           position: absolute;
           width: 500px;
           height: 200px;
           z-index: 15;
           top: 50%;
           left: 50%;
           margin: -100px 0 0 -150px;
       }

       body {font-family: "Lato", sans-serif;}

	ul.tab {
	    list-style-type: none;
	    margin: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 1px solid #ccc;
	    background-color: #f1f1f1;
	}

	/* Float the list items side by side */
	ul.tab li {float: left;}

	/* Style the links inside the list items */
	ul.tab li a {
	    display: inline-block;
	    color: black;
	    text-align: center;
	    padding: 14px 16px;
	    text-decoration: none;
	    transition: 0.3s;
	    font-size: 17px;
	}

	/* Change background color of links on hover */
	ul.tab li a:hover {
	    background-color: #ddd;
	}

	/* Create an active/current tablink class */
	ul.tab li a:focus, .active {
	    background-color: #ccc;
	}

	/* Style the tab content */
	.tabcontent {
	    display: none;
	    padding: 6px 12px;
	    border: 1px solid #ccc;
	    border-top: none;
	}
        header {
            height: 60px;
            background: #ccc;
            text-align: center;
            color: #3b5998;
            font-size: 12px;
            padding: 10px 100px;
        }

        input[type="checkbox"]{
            width: 20px; /*Desired width*/
            height: 20px; /*Desired height*/
        }

        .align-right {float: right; text-align: left; display: flex;}
        .align-left {float: left; font-size: 30px; }

        .select-board {display: flex;}
        .select-pro {padding: 0 10px;}
    </style>
  </head>
  <header>
     <div class="align-left">
         <span><h2>Car Management System</h2></span>
     </div>
     <div class="align-right">
          
              <span style="padding: 5px">{% if not login_required %}Hi, {{user.full_name}}{% endif %}</span>
              {% if not login_required %}
                  <button type="button" class="btn btn-primary" id="logout-button">Logout</button>
              {% endif %}
          
     </div>
  </header>
  <!-- Modal -->
  <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <!--<button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>-->
          <h4 class="modal-title" id="myModalLabel">Login</h4>
        </div>
      <div class="modal-body">
        
        <div class="errors"> Errors</div>
          {% bootstrap_form login_form %}
          <input type="submit" value="Submit" />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close-button">Close</button>
          <button type="button" class="btn btn-primary" id="login-button">Login</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="register-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <!--<button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>-->
          <h4 class="modal-title" id="myModalLabel">Registration</h4>
        </div>
      <div class="modal-body">
        <div class="message"> <strong>Note:</strong></div>
        <div class="errors"> Errors</div>
          
            {% bootstrap_form registration_form %}
            <input type="submit" value="Submit" />

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" id="register-button">Register</button>
        </div>
      </div>
    </div>
  </div>

    <div class="modal fade" id="add-vehicle-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <!--<button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>-->
          <h4 class="modal-title" id="myModalLabel">Add Vehicle</h4>
        </div>
      <div class="modal-body">
        <div class="message"> <strong>Note:</strong></div>
        <div class="errors"> Errors</div>
          
            {% bootstrap_form inventory_form %}
            <input type="submit" value="Submit" />

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" id="inventory-button">Add</button>
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

          {% if login_required %}
              <div class="login_required">
                <h3> Login required to access this page.<h3>
                <br>
                <span style="padding: 50px;"></span>
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#login-modal">
                    Login
                </button>

                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#register-modal">
                    Register
                </button> 
              </div>
          {% else %}
		<ul class="tab">
		  <li><a href="#" class="tablinks active" id="invntory-tab" onclick="openCity(event, 'inv')">Inventory</a></li>
                  {% if user.user_type == "admin" or user.user_type == "vadmin" %}
                      <li><a href="#" class="tablinks" onclick="openCity(event, 'add_to_inv')">Add Vehicle</a></li>
                  {% endif %}
                  {% if user.user_type == "user" %}
		  <li><a href="#" class="tablinks" onclick="openCity(event, 'wish_list')">Wish List</a></li>
                  {% endif %}
                  {% if user.user_type == "admin" %}
		  <li><a href="#" class="tablinks" onclick="openCity(event, 'pending_users')">Pending Profiles</a></li>
                  {% endif %}
		</ul>

		<div id="inv" class="tabcontent">
		  <h3>Inventory</h3>
		  
                   <div class="select-board">
                        <select id="make-select" class="select-pro">
                           <option value="">Select One</option>
                           {% for make in makes %}
                               <option value="{{make.0}}">{{make.0}}</option>
                           {% endfor %}
                        </select>
                        <span style="padding: 20px;"></span>
                        <select id="model-select" class="select-pro">
                           <option value="">Select One</option>
                        </select>
                        <span style="padding: 20px;"></span>
                        <select id="trim-select" class="select-pro">
                           <option value="">Select One</option>
                        </select>
                        <span style="padding: 20px;"></span>
                        <button type="button" class="btn btn-primary btn-lg" id="get-vehicles">Filter Vehicles</button> 
                   </div>
                   <div class="row top-buffer">
                   <span></span>
	           <table class="table" id="veh-table">
		    <thead>
		      <tr>
			<th>MAKE</th>
			<th>MODEL</th>
			<th>TRIM</th>
			<th>YEAR</th>
                        {% if user.user_type == "user" %}
                          <th>
                             <span style="padding-left:200px; "></span>
                             <button type="button" class="btn btn-link btn-lg" id="add-to">Add</button>
                             <button type="button" class="btn btn-link btn-lg" id="remove-from">Remove</button>  
                          </th>
                        {% endif %}
		      </tr>
		    </thead>
		    <tbody>
		      {% for veh in inventory %} 
		      <tr id="row-{{veh.id}}">
			<td>{{veh.make}}</td>
			<td>{{veh.model}}</td>
			<td>{{veh.trim}}</td>
                        <td>{{veh.year}}</td>
                        {% if user.user_type == "user" %}
			<td align="center">
                            <div class="checkbox">
                                <label><input type="checkbox" value="{{veh.id}}" class='wish-man' id="wish-{{veh.id}}"></label>
                            </div>
			</td>
                        {% endif %}
		      </tr>
		      {% endfor %}
		    </tbody>
		  </table>
                 </div>
                
		</div>
                {% if user.user_type == "admin" or user.user_type == "vadmin" %}
		<div id="add_to_inv" class="tabcontent">
		  <h3>Add Vehicle To Inventory</h3>
		  <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add-vehicle-modal">
                    Add Vehicle
                </button>
		</div>
                {% endif %}
                {% if user.user_type == "user" %}
		<div id="wish_list" class="tabcontent">
		  <h3>Wish List</h3>
		   <div class="row top-buffer">
                   <span></span>
	           <table class="table" id="wish-veh-table">
		    <thead>
		      <tr>
			<th>MAKE</th>
			<th>MODEL</th>
			<th>TRIM</th>
			<th>YEAR</th>
		      </tr>
		    </thead>
		    <tbody>
		      {% for wl in wish_list %} 
		      <tr id="row-{{veh.id}}">
			<td>{{wl.make}}</td>
			<td>{{wl.model}}</td>
			<td>{{wl.trim}}</td>
                        <td>{{wl.year}}</td>
		      </tr>
		      {% endfor %}
		    </tbody>
		  </table>
                 </div>
		</div>
                {% endif %}
                {% if user.user_type == "admin" %}
                 <div id="pending_users" class="tabcontent">
                  <h3>Pending approvals</h3>
                   <div class="row top-buffer">
	           <table class="table">
		    <thead>
		      <tr>
			<th>Name</th>
			<th>Email</th>
			<th>Role</th>
			<th>Action</th>
		      </tr>
		    </thead>
		    <tbody>
		      {% for profile in pending_profiles %} 
		      <tr id="row-{{profile.id}}">
			<td>{{profile.full_name}}</td>
			<td>{{profile.email}}</td>
			<td>{{profile.user_type}}</td>
			<td>
                            <button type="button" class="btn btn-link btn-lg approve-button" id="{{profile.id}}">Approve</button> 
                            <button type="button" class="btn btn-link btn-lg decline-button" id="{{profile.id}}">Decline</button>
			</td>
		      </tr>
		      {% endfor %}
		    </tbody>
		  </table>
                 </div>
                 </div>
                {%endif %}
        {% endif %}
        <pre>

        </pre>
      </div>
    </div>
    </div>
  </div>

  <script>
      $('#login-button').on('click', function(e){
        $('.errors').empty();
        $('.errors').css('display','none');
        var data = {
          'login_email': document.getElementById("id_login_email").value,
          'login_password': document.getElementById("id_login_password").value
        }
        $.ajax({
          type: "POST",
          url: "/login/",
          data: data,
          success: function(response) {
              if (response.success) {
                  document.cookie = "_user_id=" + response.user_id + "; path=/";
                  $('#login-modal').modal('hide');
                  window.location.reload();
                  clearelements();
              } else {
                  $.each(response.errors, function (key, value) {
                    $(".errors")
                      .append($("<li></li>")
                      .attr("value", key)
                      .text(value));
                  });
                  $('.errors').css('display','block');
              }
          }
        });
      });


      var clearelements = function() {
           $(':input','.form-group')
		  .not(':button, :submit, :reset, :hidden')
		  .val('')
		  .removeAttr('checked')
		  .removeAttr('selected');
      }

      $('#register-button').on('click', function(e){
        $('.errors').empty();
        $('.errors').css('display','none');
        var data = {
          'full_name': document.getElementById("id_full_name").value,
          'email': document.getElementById("id_email").value,
          'password': document.getElementById("id_password").value,
          'user_type': document.getElementById("id_user_type").value,
        }
        
        $.ajax({
          type: "POST",
          url: "/register/",
          data: data,
          success: function(response) {
              if (response.success) {
                  if(response.auto_login) {
                      document.cookie = "_user_id=" + response.user_id + "; path=/";
                      $('#register-modal').modal('hide');
                      clearelements();
                      window.location.reload();
                  }
                  else {
                      $(".message")
                          .append($("<li></li>")
                          .attr("value", "Registration is success, Adimn will approve this soon.")
                          .text("Registration is success, Adimn will approve this soon.")
                      );
                     
                      $('.message').css('display','block');
                  }
                  clearelements();
                  
              } else {
                  $.each(response.errors, function (key, value) {
                    $(".errors")
                      .append($("<li></li>")
                      .attr("value", key)
                      .text(value));
                  });
                  $('.errors').css('display','block');
              }
          }
        });
      });
      

      /*
        Adding new vehicle to inventory.
      */

      $('#inventory-button').on('click', function(e){
        $('.errors').empty();
        $('.errors').css('display','none');
        var data = {
          'make': document.getElementById("id_make").value,
          'model': document.getElementById("id_model").value,
          'trim': document.getElementById("id_trim").value,
          'year': document.getElementById("id_year").value
        }
        $.ajax({
          type: "POST",
          url: "/add_vehicle/",
          data: data,
          success: function(response) {
              if (response.success) {
                  $('#login-modal').modal('hide');
                  window.location.reload();
                  clearelements();
              } else {
                  $.each(response.errors, function (key, value) {
                    $(".errors")
                      .append($("<li></li>")
                      .attr("value", key)
                      .text(value));
                  });
                  $('.errors').css('display','block');
              }
          }
        });
      });


      $("#close-button").on('click', function(e) {
          $('.errors').empty();
          $('.errors').css('display', 'none');

          $('.message').empty();
          $('.message').css('display', 'none');

          clearelements();
      });

     

      var delete_cookie = function(name) {
          document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
      };

      var action = function(name, id) {
          data = {
              'a': name, 'user_id': id
          };

          $.ajax({
		  type: "POST",
		  url: "/action/",
		  data: data,
		  success: function(response) {
		      if (response.success) {
		          $("#row-" + id).remove();
		      } else {
		          alert(response.errors);
		      }
		  }
          });
      }

      $("#logout-button").on('click', function(e) {
          delete_cookie('_user_id');
          window.location.reload();
      });

      $(".approve-button").on('click', function(e) {
          action('APP', this.id);
      });

      $(".decline-button").on('click', function(e) {
          action('DEC', this.id);
      });

      

      /*
        Inventory select.
      */

      var selectInventory = function(uri, id) {
          $("#" + id + " option").each(function() {
		$(this).remove();
	  });

          $.ajax({
		  type: "GET",
		  url: uri,
		  success: function(response) {
		      if (response.success) {
                          console.log(response.options);
                          
		          $.each(response.options, function (i, item) {
                            console.log(item);
			    $('#' + id).append($('<option>', { 
				value: item,
				text : item 
			    }));
			  });
		      } else {
		          alert(response.errors);
		      }
		  }
          });
      }

      $("#make-select").change(function () {
        var uri = "/getopt?make=" + this.value + "&required=models";
        selectInventory(uri, "model-select")
      });

      $("#model-select").change(function () {
        var make = $("#make-select").val();
        var uri = "/getopt?make=" + make + "&model="+ this.value +"&required=trims";
        selectInventory(uri, "trim-select")
      });


      function changeTable(data, wish, id) {
         $("#" + id + " > tbody").empty();
         $.each(data, function (i, item) {
           if (!wish) {
             $("#" + id + " tbody").append(
		"<tr id=" + "row-" + item.id + ">"+
		"<td>" + item.make + "</td>"+
		"<td>" + item.model + "</td>"+
		"<td>" + item.trim + "</td>"+
                "<td>" + item.year + "</td>"+
		"</tr>"
             );
           }
           else {
             var check = "<div class='checkbox'>" +
                         "<label><input type='checkbox' value='" + item.id + "' class='wish-man' id='wish-" + item.id + "'></label>" +
                         "</div>";
             $("#" + id + " tbody").append(
		"<tr id=" + "row-" + item.id +">" +
		"<td>" + item.make + "</td>"+
		"<td>" + item.model + "</td>"+
		"<td>" + item.trim + "</td>"+
                "<td>" + item.year + "</td>"+
                "<td align='center'>" + check + "</td>" +
		"</tr>"
             );
           }
	 });
       };

      function getVehicles(uri){

          $.ajax({
		  type: "GET",
		  url: uri,
		  success: function(response) {
		      if (response.success) {
                         
		          $.each(response.options, function (i, item) {
			    changeTable(response.options, response.wish, "veh-table");
			  });
		      } else {
		          alert(response.errors);
		      }
		  }
          });

	};

       $("#get-vehicles").on('click', function(e) {
           var uri = "/getveh?make=" + $("#make-select").val() +
                     "&model="+ $("#model-select").val() +
                     "&trim="+$("#trim-select").val();
           getVehicles(uri)
       });

       /*
         Wish list part.
       */

       function markToWish(uri) {
           $.ajax({
		  type: "GET",
		  url: uri,
		  success: function(response) {
		      if (response.success) {
		          $.each(response.options, function (i, item) {
			    changeTable(response.options, response.wish);
			  });
		      } else {
		          alert(response.errors);
		      }
		  }
          });
       }

       $("#add-to").on('click', function(e) {
            var matches = "";
            $(".wish-man:checked").each(function() {
		  matches = matches + "-" + this.value;
            });
            var uri = "/markwish?q=" + matches + "&flag=add";
            markToWish(uri);         
       });

       $("#remove-from").on('click', function(e) {
            var matches = "";
            $(".wish-man:checked").each(function() {
		  matches = matches + "-" + this.value;
            });
            var uri = "/markwish?q=" + matches + "&flag=remove";
            markToWish(uri);         
       });

       function getWishList(uri){

          $.ajax({
		  type: "GET",
		  url: "/getwish/",
		  success: function(response) {
		      if (response.success) {
		          $.each(response.options, function (i, item) {
			    changeTable(response.options, false, "wish-veh-table");
			  });
		      } else {
		          alert(response.errors);
		      }
		  }
          });

	};

        function openCity(evt, cityName) {
	    var i, tabcontent, tablinks;
	    tabcontent = document.getElementsByClassName("tabcontent");
	    for (i = 0; i < tabcontent.length; i++) {
		tabcontent[i].style.display = "none";
	    }
	    tablinks = document.getElementsByClassName("tablinks");
	    for (i = 0; i < tablinks.length; i++) {
		tablinks[i].className = tablinks[i].className.replace(" active", "");
	    }
	    document.getElementById(cityName).style.display = "block";
	    evt.currentTarget.className += " active";

            if (cityName == "wish_list") {
                getWishList();
            }
	}
        $(document).ready(function() {
            var elem = document.getElementById("invntory-tab");
            elem.onclick.apply(elem);
        });

  </script>
</html>
