
from django.http import JsonResponse
from django.shortcuts import render

from cars.forms import InventoryForm, LoginForm, RegistrationForm
from cars.models import Inventory, User


def cars(request):
    """
    Listing all the available schedules.
    """

    context  = {
        'inventory_form': InventoryForm,
        'login_form': LoginForm,
        'registration_form': RegistrationForm,
        'inventory': Inventory.objects.all(),
        'makes': Inventory.objects.order_by().values_list('make').distinct()
    }

    if not request.COOKIES.get('_user_id'):
        context.update({'login_required': True})
    else:
        context.update({
            'user': User.objects.get(id=int(request.COOKIES.get('_user_id'))),
            'pending_profiles': User.objects.pending_profiles()
        })

        context.update({
            'wish_list': context['user'].wish_list.all()
        })

    return render(request, 'cars.tpl', context)


def login(request):
    """
    Login view.
    """
    response = {'success': False}
    if request.method == "POST":
        form = LoginForm(request.POST)

        if form.is_valid():
            response.update({
                'user_id': form.cleaned_data['user'].id,
                'success': True
            })
        else:
            response.update({
                'errors': form.errors
            })

    return JsonResponse(response)


def register(request):
    response = {'success': False}
    form = RegistrationForm

    if request.method == 'POST':
        form = form(request.POST)
        if form.is_valid():
            user = form.save()
            
            response.update({
                'success': True,
                'auto_login': form.cleaned_data['user_type'] != "vadmin",
                'user_id': user.id
            })
        else:
            response.update({
                'errors': form.errors
            })

    return JsonResponse(response)  # render(request, 'registration.tpl', context)


def action(request):
    """
    Method to take action on user registration.
    """
    response = {"success": False}

    if request.method == "POST":
        request_type = request.POST.get("a")
        user_id = int(request.POST.get("user_id"))

        try:
            is_approve = (True if request_type == "APP" else False)
            User.objects.filter(pk=user_id).update(approved=is_approve)
        except Exception:
            response.update({"error": "User doesn't exist"})

        else:
            response.update({"success": True})

    return JsonResponse(response)


def add_to_inventory(request):
    """
    View to manage adding new vehicle to inventory.
    """

    response = {'success': False}
    form = InventoryForm

    if request.method == 'POST':
        form = form(request.POST)
        if form.is_valid():
            vehicle = form.save()
            response.update({
                'success': True,
            })
        else:
            response.update({
                'errors': form.errors
            })

    return JsonResponse(response)


def get_options(request):
    """View to get vehicle filter options."""

    response = {'success': False}
    if request.method == 'GET':

        req = request.GET.get("required")
        make = request.GET.get("make")
        model = request.GET.get("model")

        options = [""]
        if req == "models":
            options.extend([i[0] for i in Inventory.objects.get_models(make)])
        elif req == "trims":
            options.extend([i[0] for i in Inventory.objects.get_trims(make, model)])
        response.update({
            'success': True,
            'options': options
        })

    return JsonResponse(response)


def get_vehicles(request):
    """View to get vehicle information from the inventory."""

    response = {'success': False}
    if request.method == 'GET':
        user_id = request.COOKIES.get("_user_id")
        user = User.objects.get(pk=int(user_id))
        kwargs = {
            'make': request.GET.get("make"),
            'model': request.GET.get("model"),
            'trim': request.GET.get("trim")
        }

        options = [i for i in Inventory.objects.get_objects(**kwargs)]
        response.update({
            'success': True,
            'options': options,
            'wish': user.user_type == "user"
        })

    return JsonResponse(response)


def mark_wish(request):
    """View to get vehicle information from the inventory."""

    response = {'success': False}

    if request.method == 'GET':

        user_id = request.COOKIES.get("_user_id")
        user = User.objects.get(pk=int(user_id))

        inventory_ids = [int(i) for i in request.GET.get("q", "").split("-") if i]
        flag = request.GET.get("flag")

        inventory_objs = [obj for obj in Inventory.objects.filter(id__in=inventory_ids)]

        if flag == "add":
            user.wish_list.add(*inventory_objs)
        elif flag == "remove":
            user.wish_list.remove(*inventory_objs)
       

        kwargs = {
            'make': request.GET.get("make"),
            'model': request.GET.get("model"),
            'trim': request.GET.get("trim")
        }

        options = [i for i in Inventory.objects.get_objects(**kwargs)]
        response.update({
            'success': True,
        })

    return JsonResponse(response)


def get_wish_list(request):
    """ View to get the wish list of vehicles."""

    response = {'success': False}
    if request.method == 'GET':
        user_id = request.COOKIES.get("_user_id")
        user = User.objects.get(pk=int(user_id))

        options = [i for i in user.wish_list.all().values()]
        response.update({
            'success': True,
            'options': options,
        })

    return JsonResponse(response)
