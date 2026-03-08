import 'dart:developer';
import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitGetAll__infoUsers.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetAll_infoUsers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopConteanerProfilePage extends StatelessWidget {
  const TopConteanerProfilePage({super.key, required this.pop});

  final bool pop;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cubitGetAll__infoUsers, StategetallInfousers>(
      builder: (context, state) {
        if (state is StateLoad) {
          return const _LoadingView();
        }

        if (state is StateFaield) {
          log(state.errType);
          return const _ErrorView();
        }

        if (state is StateSucsess) {
          return _ProfileHeader(pop: pop, state: state);
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: Center(child: Text("Error")));
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.state, required this.pop});

  final StateSucsess state;
  final bool pop;

  @override
  Widget build(BuildContext context) {
    final user = state.allInfoUsers;

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              offset: Offset(1, 1),
              blurRadius: 5,
            ),
          ],
          gradient: LinearGradient(colors: colors),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              if (pop)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),

              const SizedBox(width: 10),

              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          Text(
                            "${user.performance}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            user.userId,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 32,
                child: CircleAvatar(
                  foregroundColor: Colors.black,
                  radius: 30,
                  backgroundImage: NetworkImage(user.urlImage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
