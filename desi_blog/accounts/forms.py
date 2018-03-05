from django.contrib.auth import authenticate, login, logout, get_user_model
from django import forms

User = get_user_model()


class UserLoginForm(forms.Form):
    username = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput)

    def clean(self):
        username = self.cleaned_data.get("username", None)
        password = self.cleaned_data.get("password", None)

        if username and password:
            user = authenticate(username=username, password=password)

            if not user:
                raise forms.ValidationError("Username or Password is incorrect")

            if not user.is_active:
                raise forms.ValidationError("Username or Password is incorrect")

            return super(UserLoginForm, self).clean()


class UserRegisterForm(forms.ModelForm):
    # username = forms.CharField(label='Username')
    email = forms.EmailField(label='Email Address')
    password = forms.CharField(widget=forms.PasswordInput)
    password_conf = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'password_conf']

    def clean(self):
        email = self.cleaned_data.get('email')

        password = self.cleaned_data.get('password')
        password_conf = self.cleaned_data.get('password_conf')

        email_qs = User.objects.filter(email=email)
        if email_qs.exists():
            raise forms.ValidationError("This Email Id is already registered")

        if password != password_conf:
            raise forms.ValidationError("Passwords do not match")

        return super(UserRegisterForm, self).clean()


class PasswordResetEmailForm(forms.ModelForm):
    email = forms.EmailField(label='Email Address')

    class Meta:
        model = User
        fields = ['email', ]

    def clean(self):
        email = self.cleaned_data.get('email')

        email_qs = User.objects.filter(email=email)
        if not email_qs.exists():
            raise forms.ValidationError("This Email Id does not exist")

        return super(PasswordResetEmailForm, self).clean()


class PasswordResetForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    password_conf = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ['password', 'password_conf', ]

    def clean(self):
        password = self.cleaned_data.get('password')
        password_conf = self.cleaned_data.get('password_conf')

        if password != password_conf:
            raise forms.ValidationError("Passwords do not match")

        return super(PasswordResetForm, self).clean()


class PasswordChangeForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    password_conf = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ['password', 'password_conf', ]

    def clean(self):
        password = self.cleaned_data.get('password')
        password_conf = self.cleaned_data.get('password_conf')

        if password != password_conf:
            raise forms.ValidationError("Passwords do not match")

        return super(PasswordChangeForm, self).clean()
