from django.db import models
from django.utils import timezone
# Create your models here.


USER_CHOICES = [
    ('admin', 'Admin'),
    ('vadmin', 'Vehicle Admin'),
    ('user', 'General User')
]


class UserManager(models.Manager):

    def pending_profiles(self):
        return self.filter(approved=None, user_type="vadmin")

    def get_queryset(self):
        return super(UserManager, self).get_queryset().order_by('full_name')


class InventoryManager(models.Manager):
   # import pdb;pdb.set_trace()

    def get_models(self, make):
        return self.filter(make=make).order_by('model').values_list('model').distinct()
        
    def get_trims(self, make, model):
        return self.filter(make=make, model=model).order_by('trim').values_list('trim').distinct()

    def get_objects(self, **kwargs):
        temp_dict = {}
        for key in kwargs:
            if kwargs[key]:
                temp_dict[key] = kwargs[key]
        return self.filter(**temp_dict).order_by('model').values()
       

class Inventory(models.Model):
    """Inventory model."""

    make = models.CharField(max_length=100)
    model = models.CharField(max_length=100)
    trim = models.CharField(max_length=50)
    year = models.IntegerField()

    objects = InventoryManager()


class User(models.Model):

    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True) 
    password = models.CharField(max_length=15)
    user_type = models.CharField(choices=USER_CHOICES, max_length=10)

    approved = models.NullBooleanField(null=True)
    registration_time = models.DateTimeField(null=True)
    approved_time = models.DateTimeField(null=True)

    wish_list =  models.ManyToManyField(Inventory)

    objects = UserManager()

    def save(self, *args, **kwargs):
        ''' On save, update timestamps '''
        if not self.registration_time:
            self.registration_time = timezone.now()

        if not self.approved_time and not self.approved:
            self.approved_time = timezone.now()

        if self.approved is None and self.user_type != 'vadmin':
            self.approved = True

        return super(User, self).save(*args, **kwargs)

