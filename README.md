GROUP NO. 06 MEMBERS COLLABORATED IN MOBILE CHAT APPLICATION
Samwel japhet jamson nit/bcs/2023/493
Anold Joachim John     nit/bcs/2023/540
Catherine Coisasi Mollel nit/bcs/2023/610
Gibson Emmanuel Yohana  nit/bcs/2023/609
Alistides Augustin nit/bcs/2023/484
Mshashi George  nit/bcs/2023/605
Kelvin kamuniga Seperatus nit/bcs/2023/591
Elisha Godluck sommy nit/bcs/2023/555
Karim Novath Makale nit/bcs/2023/603
Benjamin Seleman Said  nit/bcs/2023/583

## Security & Configuration

To protect our sensitive data and API keys, certain configuration files have been removed from this repository and added to `.gitignore`.

### Required Files
If you have just cloned this repository, you will need to manually add the following files to run the project:

1.  **`lib/firebase_options.dart`** - Contains Firebase project configurations.
2.  **`android/app/google-services.json`** - Required for Android Firebase integration.
3.  **`ios/Runner/GoogleService-Info.plist`** - Required for iOS Firebase integration.

### How to setup:
* **Existing Collaborators:** If you already had these files, ensure you keep a local backup before performing a `git pull`.
* **New Contributors:** Please contact the project administrator (Samue Jameson) to receive the secure configuration files via a private channel.
* **Environment Variables:** If you are using an `.env` file, make sure to create a copy of `.env.example`, rename it to `.env`, and populate it with the correct API keys.

**Note:** Never commit these files back to the repository.
