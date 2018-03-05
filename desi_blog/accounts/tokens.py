from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils import six
from datetime import datetime, timedelta
import cryptography
from cryptography.fernet import Fernet


class ExpiringTokenGenerator:
    FERNET_KEY = 'M3_R9rBSshoo4CCcaSXHULvHIwLKX37ymJINed4K2_Y='
    fernet = Fernet(FERNET_KEY)

    DATE_FORMAT = '%Y-%m-%d %H-%M-%S'
    EXPIRATION_DAYS = 1

    def get_time(self):
        """Returns a string with the current UTC time"""
        return datetime.utcnow().strftime(self.DATE_FORMAT)

    def parse_time(self, d):
        """Parses a string produced by get_time and returns a datetime object"""
        return datetime.strptime(d, self.DATE_FORMAT)

    def generate_token(self, text):
        """Generates an encrypted token"""
        full_text = text + '|' + self.get_time()
        token = self.fernet.encrypt(bytes(full_text))

        return token

    def get_token_value(self, token):
        """Gets a value from an encrypted token.

        Returns None if the token is invalid or has expired.
        """
        try:
            value = self.fernet.decrypt(bytes(token))
            separator_pos = value.rfind('|')

            text = value[: separator_pos]
            token_time = self.parse_time(value[separator_pos + 1:])

            if token_time + timedelta(self.EXPIRATION_DAYS) < datetime.utcnow():
                return None

        except cryptography.fernet.InvalidToken:
            return None

        return text

    def is_valid_token(self, token):
        return self.get_token_value(token) != None


account_activation_token = ExpiringTokenGenerator()
