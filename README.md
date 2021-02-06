# Codeit KSS Git Client

A Flutter app to access daily programs written by members of a coding community from their git repos.

**Platforms**: Android, iOS, Web

## What is it used for?
A South Indian coding community named ***Code-it*** conducts **Knowledge Sharing Session(KSS)** daily, where daily practice problems are shared. The members code the solutions and push it to their github repo in a certain filename format.

The managing authorities and volunteers of the community use this app to check the completion status of members' programs and to view/verify if completed.

## How it works?
The app is built with Flutter, which is a dart framework developed by Google. This single codebase can be compiled to Android, iOS, web, Linux and Window where it runs just like another native application.

The app contains list of members of the community along with their github usernames. Provided a date or a range of dates through the app's User Interface, it fetches the code file from members' Github repositories. This is possible as all members follow a single convention for their repos and code files. 

This app doesn't use Github API, but directly fetches the file from `https://raw.githubusercontent.com/<username>/<reponame>/<filename>`

[Click here](https://sundarlucifer.github.io/Codeit-KSS-Flutter) to checkout the web version of the app.
