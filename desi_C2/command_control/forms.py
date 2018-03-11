from .models import Listener
from django import forms
from .models import Script


class ListenerForm(forms.ModelForm):
    title = forms.CharField(label='name')
    interface = forms.GenericIPAddressField(label='listener IP')
    port = forms.IntegerField(label='listener port')

    class Meta:
        model = Listener
        fields = ['title', 'interface', 'port', ]


class TerminalForm(forms.ModelForm):
    title = forms.CharField(label='name')
    interface = forms.GenericIPAddressField(label='listener IP')
    port = forms.IntegerField(label='listener port')

    class Meta:
        model = Listener
        fields = ['title', 'interface', 'port', ]


class ScriptForm(forms.ModelForm):
    class Meta:
        model = Script
        fields = '__all__'

    class Media:
        css = {
            'all': (
                'css/codemirror.css',
                'css/highlight.min.css'
            )
        }
        js = (
            'js/codemirror.js',
            'js/python.js',
            'js/highlight.min.js',
)