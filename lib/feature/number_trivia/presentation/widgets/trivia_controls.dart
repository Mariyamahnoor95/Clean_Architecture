import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/number_trivia_bloc.dart';

class TriviaController extends StatefulWidget {
  const TriviaController({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaController> createState() => _TriviaControllerState();
}

class _TriviaControllerState extends State<TriviaController> {
  final controller = TextEditingController();
  late String inputString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a number',
          ),
          onChanged: (value){
            inputString =value;
          },
          onSubmitted: (_){
            dispatchConcrete();
          },
        ),
        const SizedBox(height: 10,),
        Row(
          children:  [
            Expanded(child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: dispatchConcrete,
              child: Text('Search'),
            ),
            ),
            const SizedBox(width: 10,),
            Expanded(child:ElevatedButton(
              onPressed: dispatchRandom,
              child: const Text('Get Number Trivia'),
            ),)
          ],
        )
      ],
    );
  }

  void dispatchConcrete(){
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(inputString));
  }
  void dispatchRandom(){
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}
