import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isfa_crm/login_module/bloc/login_bloc.dart';
import 'package:isfa_crm/login_module/login_repository.dart';
import 'package:isfa_crm/utility/extensions.dart';

import '../routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Center(
        child: RepositoryProvider(
          create: (context) => LoginRepository(),
          child: BlocProvider(
            create: (context) => LoginBloc(context.read()),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginedSuccessfullState) {
                  context.hideKeyboard();
                  context.go(AppPaths.tabbar);
                } else if (state is MoveToSetPinState) {
                  // context.push(AppPaths.pinset, extra: context.read<LoginBloc>());
                }
              },
              builder: (context, state) {
                var bloc = context.read<LoginBloc>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Login to iSFA CRM",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (state is LogInErrorState)
                      Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          TextField(
                            controller: usernameController,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(" ")
                            ],
                            onChanged: (change) {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginTextChangeEvent(usernameController.text,
                                      passwordController.text));
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              filled: true,
                              fillColor: Color.fromARGB(255, 230, 230, 230),
                              hintText: "Username",
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(" ")
                            ],
                            onChanged: (change) {
                              bloc.add(LoginTextChangeEvent(
                                  usernameController.text,
                                  passwordController.text));
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                context.read<LoginBloc>().isShowingPassword,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 230, 230, 230),
                              hintText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    bloc.add(LoginShowPasswordButtonEvent()),
                                icon: Icon(
                                  state is LogInShowPasswordState
                                      ? state.visible
                                          ? Icons.visibility
                                          : Icons.visibility_off
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 190,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: MaterialButton(
                              onPressed: () {
                                if (state is! LogInLoadingState) {
                                  context.hideKeyboard();
                                  bloc.add(LoginSubmitEvent(
                                      usernameController.text,
                                      passwordController.text));
                                }
                              },
                              child: Text(
                                state is LogInLoadingState
                                    ? "Loading...."
                                    : "LOGIN",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
