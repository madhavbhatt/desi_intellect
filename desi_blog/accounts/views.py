from __future__ import unicode_literals
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.sites.shortcuts import get_current_site
from django.http import HttpResponseRedirect, HttpResponse, Http404
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout, get_user_model
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from .forms import UserLoginForm, UserRegisterForm, PasswordResetForm, PasswordResetEmailForm, PasswordChangeForm
from django.views.decorators.cache import never_cache
from django.views.decorators.clickjacking import *
from django.core.mail import send_mail, EmailMessage
from tokens import account_activation_token


User = get_user_model()


@xframe_options_deny
@never_cache
def login_view(request):
    logout(request)
    form = UserLoginForm(request.POST or None)
    next = request.GET.get('next')
    if form.is_valid():
        username = form.cleaned_data.get("username")
        password = form.cleaned_data.get("password")
        user = authenticate(username=username, password=password)
        login(request, user)
        if next:
            return redirect(next)
        return redirect("/")
    return render(request, "user_login.html", {"form": form})


@xframe_options_deny
@never_cache
def register_view(request):
    form = UserRegisterForm(request.POST or None)
    if form.is_valid():
        user = form.save(commit=False)
        password = form.cleaned_data.get("password")
        user.set_password(password)
        user.is_active = False
        user.save()
        current_site = get_current_site(request)
        mail_subject = 'Activate your blog account.'
        message = render_to_string('account_activation_email.html', {
            'user': user,
            'domain': current_site.domain,
            'uid': urlsafe_base64_encode(force_bytes(user.pk)),
            'token': account_activation_token.generate_token(user.username),
        })
        to_email = form.cleaned_data.get('email')
        email = EmailMessage(
            mail_subject, message, to=[to_email]
        )
        email.send()
        return HttpResponse('Thank you for your Registration. An Email Has been sent to you for confirmation.')
    return render(request, 'user_login.html', {'form': form})


@xframe_options_deny
@never_cache
def activate(request, uidb64, token):
    try:
        uid = force_text(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except(TypeError, ValueError, OverflowError, User.DoesNotExist):
        user = None

    valid_token = account_activation_token.is_valid_token(token)

    if token not in open('acc_activate.txt').read():
        if user is not None and valid_token is not None:
            user.is_active = True
            acc_activate = open('acc_activate.txt', 'a')
            acc_activate.write(token)
            acc_activate.close()
            user.save()
            return HttpResponse('Thank you for your email confirmation. Now you can login your account.')
        else:
            return HttpResponse('Activation link is invalid!')
    else:
        return HttpResponse('This Link Has Expired')

@xframe_options_deny
@never_cache
def logout_view(request):
    logout(request)
    return HttpResponseRedirect("/")


@xframe_options_deny
@never_cache
def forgot_password(request):
    form = PasswordResetEmailForm(request.POST or None)
    if form.is_valid():
        to_email = form.cleaned_data.get('email')
        user = User.objects.get(email__iexact=to_email)
        current_site = get_current_site(request)
        mail_subject = 'Someone Requested Password Reset'
        message = render_to_string('password_reset_confirm.html', {
            'user': user,
            'domain': current_site.domain,
            'uid': urlsafe_base64_encode(force_bytes(user.pk)),
            'token': account_activation_token.generate_token(user.username)
        })
        email = EmailMessage(
            mail_subject, message, to=[to_email]
        )
        email.send()
        return HttpResponse('An Email Has been sent to you for password reset.')
    return render(request, 'forgot_password.html', {'form': form})


@xframe_options_deny
@never_cache
def password_reset(request, uidb64, token):
    try:
        uid = force_text(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except(TypeError, ValueError, OverflowError, User.DoesNotExist):
        user = None

    valid_token = account_activation_token.is_valid_token(token)
    if token not in open('pass_reset.txt').read():
        if user is not None and valid_token is not None:
            form = PasswordResetForm(request.POST or None)
            if form.is_valid():
                user = User.objects.get(username__iexact=user)
                password = form.cleaned_data.get("password")
                user.set_password(password)
                user.save()
                pass_reset = open('pass_reset.txt', 'a')
                pass_reset.write(token)
                pass_reset.close()
                current_site = get_current_site(request)
                mail_subject = 'Your password was recently changed'
                message = render_to_string('password_reset_done.html', {
                    'user': user,
                    'domain': current_site.domain,
                })
                email = EmailMessage(
                    mail_subject, message, to=[user.email]
                )
                email.send()
                return HttpResponse("Your Password has been reset. You can Login now !")
            return render(request, 'password_reset_form.html', {'form': form})
        else:
            return HttpResponse('Link is invalid!')
    else:
        return HttpResponse('This Link Has Expired')


@xframe_options_deny
@never_cache
@login_required
def password_change(request):
    form = PasswordChangeForm(request.POST or None)
    if form.is_valid():
        user = User.objects.get(username__iexact=request.user)
        password = form.cleaned_data.get("password")
        user.set_password(password)
        user.save()
        return HttpResponse('Your Password has been changed')
    return render(request, 'password_change_form.html', {'form': form})
