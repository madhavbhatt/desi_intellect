from django.contrib import messages
from django.http import HttpResponse, Http404, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404, redirect
from django.utils import timezone
from .models import Listener
from .forms import ListenerForm
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from django.views.decorators.clickjacking import *
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from c2 import connect


@xframe_options_deny
@never_cache
def home(request):
    listeners = Listener.objects.filter()
    return render(request, 'index.html', {'listeners': listeners})


@xframe_options_deny
@never_cache
def listener_list(request):
    listeners = Listener.objects.filter()
    return render(request, 'listener_list.html', {'listeners': listeners})


@xframe_options_deny
@never_cache
def listener_detail(request, pk):
    try:
        listener = get_object_or_404(Listener, pk=pk)
    except:
        raise Http404

    return render(request, 'listener_detail.html', {'listener': listener})


@xframe_options_deny
@never_cache
# @login_required  # (login_url='/login/')
def listener_new(request):
    if request.method == "POST":
        form = ListenerForm(request.POST)
        if form.is_valid() and request.user.is_authenticated():
            listener = form.save(commit=False)
            listener.author = request.user
            listener.title = form.cleaned_data['title']
            listener.interface = form.cleaned_data['interface']
            listener.port = form.cleaned_data['port']
            listener.save()
            return redirect('listener_detail', pk=listener.pk)
    else:
        form = ListenerForm()
    return render(request, 'listener_edit.html', {'form': form})


@xframe_options_deny
@never_cache
# @login_required  # (login_url='/login/')
def listener_edit(request, pk):
    try:
        listener = get_object_or_404(Listener, pk=pk)
    except:
        raise Http404

    if listener.author != request.user:
        response = HttpResponse("You do not have permission to edit this listener")
        response.status_code = 403
        return response

    if request.method == "POST":
        form = ListenerForm(request.POST, instance=listener)
        if form.is_valid() and request.user.is_authenticated():
            listener = form.save(commit=False)
            listener.title = form.cleaned_data['title']
            listener.interface = form.cleaned_data['interface']
            listener.port = form.cleaned_data['port']
            listener.save()
            return redirect('listener_detail', pk=listener.pk)
    else:
        form = ListenerForm(instance=listener)
    return render(request, 'listener_edit.html', {'form': form})


@xframe_options_deny
@never_cache
# @login_required  # (login_url='/login/')
def listener_delete(request, pk):

    try:
        listener = get_object_or_404(Listener, pk=pk)
    except:
        raise Http404

    if request.method == "POST":
        if listener.author != request.user:
            response = HttpResponse("You do not have permission to edit this listener")
            response.status_code = 403
            return response

        if request.user.is_authenticated():
            Listener.objects.filter(id=listener.pk).delete()
            messages.info(request, "The listener has been deleted")
        return redirect("/")

    return render(request, 'confirm_listener_delete.html', {'listener': listener})


def terminal(request):
    listeners = Listener.objects.filter()
    return render(request, 'term.html', {'listeners': listeners})


@csrf_exempt
def result(request):
    param = request.POST.get('command')
    print(param)
    output = connect(param)
    print(output)
    return HttpResponse(output)
