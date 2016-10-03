
from django import forms
from cars.models import Inventory, User


class LoginForm(forms.Form):

    login_email = forms.EmailField(required=True)
    login_password = forms.CharField(widget=forms.PasswordInput, required=True)

    def clean_login_email(self):
        email = self.cleaned_data.get('login_email')
        if email:
            try:
                user = User.objects.get(email=email)
            except User.DoesNotExist:
                raise forms.ValidationError("Email does not exist.")
        return email

    def clean(self):
        email = self.cleaned_data.get('login_email')
        password = self.cleaned_data.get('login_password')
        if password:
            try:
                user = User.objects.get(email=email, password=password)
                if user.user_type == "vadmin" and not user.approved:
                    mesg = "".join([
                         "Registration is ",
                         ("not yet approved" if user.approved is None else "declined"),
                         " by the admin"
                    ])
                    raise forms.ValidationError(mesg)
                self.cleaned_data.update({'user': user})
            except User.DoesNotExist:
                raise forms.ValidationError("Email/Password doesn't match.")
        return self.cleaned_data
            


class RegistrationForm(forms.ModelForm):

    class Meta:
        model = User
        fields = ['full_name', 'email', 'password', 'user_type']

        widgets = {
            'password': forms.PasswordInput(),
        }


class InventoryForm(forms.ModelForm):

    class Meta:
        model = Inventory
        exclude = []
