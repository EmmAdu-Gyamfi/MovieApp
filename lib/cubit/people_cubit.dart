import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/people.dart';
import 'package:movie_app/pages/settings.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());

  final _dio = Dio();

  Future <void> loadPeople(int peopleId) async {
   try{
     emit(PeopleLoadingInProgress());
     var response = await _dio.get("${baseUrl}person/$peopleId?api_key=$apiKey");
     if(response.statusCode == 200){
       var people = People.fromJson(response.data);
       emit(PeopleLoadingSucceeded(people));
     } else {
       emit(PeopleLoadingFailed(response.statusMessage.toString()));
     }
   } catch(e){
      emit(PeopleLoadingFailed(e.toString()));
   }

  }
  }


