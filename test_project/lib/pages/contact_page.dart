import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/bloc/contact_cubit.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerMessage = TextEditingController();

  ContactCubit get _cubit => context.read();

  void _initListeners() {
    _controllerName.addListener(() {
      _cubit.setName = _controllerName.text;
    });

    _controllerEmail.addListener(() {
      _cubit.setEmail = _controllerEmail.text;
    });

    _controllerMessage.addListener(() {
      _cubit.setMessage = _controllerMessage.text;
    });
  }

  void _errorHandler(BuildContext context, String value) {
    final snackBar = SnackBar(
      content: Text(value),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();

    _initListeners();
  }

  @override
  void dispose() {
    _controllerName.removeListener(() {});
    _controllerEmail.removeListener(() {});
    _controllerMessage.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
              color: Colors.black,
            ),
            elevation: 0,
            title: const Text(
              'Contact us',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _buildFieldName(state),
                  const SizedBox(height: 20),
                  _buildFieldEmail(state),
                  const SizedBox(height: 20),
                  _buildFieldMessage(state),
                  const SizedBox(height: 40),
                  _buildButton(state),
                  const SizedBox(height: 40),
                  Text(state.status),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldName(ContactState state) {
    final valid = state.nameValidation;
    return Row(
      children: [
        _buildLockIcon(),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _controllerName,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              hintText: 'Name',
              errorText: valid ? null : 'Enter the name please',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldEmail(ContactState state) {
    final valid = state.emailValidation;
    return Row(
      children: [
        _buildLockIcon(),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _controllerEmail,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              hintText: 'Email',
              errorText: valid ? null : 'Enter correct email',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldMessage(ContactState state) {
    final valid = state.messageValidation;
    return Row(
      children: [
        _buildLockIcon(),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _controllerMessage,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              hintText: 'Message',
              errorText: valid ? null : 'Enter message please',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLockIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5E9),
        borderRadius: BorderRadius.circular(50),
      ),
      child: SvgPicture.asset(
        "assets/svg/lock.svg",
        width: 32,
        height: 32,
      ),
    );
  }

  Widget _buildButton(ContactState state) {
    final enable = state.buttonEnable;
    final loading = state.loading;
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: loading
            ? null
            : () => _cubit.sendCredentials((value) {
                  _errorHandler(context, value);
                }),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: enable ? const Color(0xFF986D8E) : const Color(0xFF5E5D5E),
          ),
          child: Text(
            loading ? 'Please wait...' : 'Send',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
