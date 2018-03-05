from .models import keygen
import os
from django.conf import settings
import shutil
import sqlite3


def secure_idor(post):
    try:
        idor = keygen()
        image_file = str(post.image)
        old_file = str(settings.MEDIA_ROOT + "/" + image_file)
        filename, file_extension = os.path.splitext(image_file)
        new_image_file = str("media/" + str(idor) + file_extension)
        new_file = str(settings.MEDIA_ROOT + "/media/" + str(idor) + file_extension)
        shutil.move(old_file, new_file)
        post.image = str(new_image_file)
        return post
    except:
        pass
