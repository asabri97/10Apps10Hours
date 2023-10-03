import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_profile_app/github_user.dart';
import 'package:http/http.dart' as http;

class GitHubProfileApps extends StatefulWidget {
  const GitHubProfileApps({super.key});

  @override
  State<GitHubProfileApps> createState() => _GitHubProfileAppsState();
}

class _GitHubProfileAppsState extends State<GitHubProfileApps> {
  late Future<GithubUser> githubUser;
  final searchController = TextEditingController();
  @override
  void initState() {
    githubUser = fetchGithubUser('asabri97');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Profiles App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(hintText: 'Search username'),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<GithubUser>(
                future: githubUser,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return const Center(child: Text('User not found'));
                  }

                  if (snapshot.data == null) {
                    return const Center(child: Text('Find a user'));
                  }
                  final user = snapshot.data;
                  return Column(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.avatarUrl),
                      radius: 70,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.login,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(user.location),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('Repositories'),
                            Text(user.publicRepos.toString())
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Following'),
                            Text(user.following.toString())
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Followers'),
                            Text(user.followers.toString())
                          ],
                        ),
                      ],
                    )
                  ]);
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            githubUser = fetchGithubUser(searchController.text);
          });
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

Future<GithubUser> fetchGithubUser(String user) async {
  final response =
      await http.get(Uri.parse('https://api.github.com/users/$user'));
  if (response.statusCode == 200) {
    return GithubUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed');
  }
}
