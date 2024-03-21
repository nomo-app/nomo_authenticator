# Nomo Authenticator

Nomo Authenticator is a simple and secure 2FA (Two Factor Authentication) app. It is based on the Time-based One-Time Password (TOTP) algorithm and is compatible with Google Authenticator.

Nomo Authenticator is built with Flutter Web for scanning QR codes is only supported when running within the Nomo app.

## Features

- **Simple**: Nomo Authenticator is designed to be simple and easy to use. It has a clean and minimalistic user interface.
- **Secure**: Nomo Authenticator is built with security in mind. It uses the TOTP algorithm to generate one-time passwords and does not require any network access.
- **Open Source**: Nomo Authenticator is open source and its source code is available on [GitHub](https://github.com/nomo-app/nomo_authenticator.git).
- **Multiple Accounts**: Nomo Authenticator supports adding multiple accounts.

## How to run

```
git submodule update --recursive --init
flutter pub get
flutter run -d chrome
```
