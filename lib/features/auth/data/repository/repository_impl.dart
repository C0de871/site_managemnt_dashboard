import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/shared/data/response_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/user_local_data_source.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> loginUser(
    Map<String, dynamic> body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.login(body);
        localDataSource.saveAccessToken(response.token);
        localDataSource.saveUser(response);
        return Right(response);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      } catch (e) {
        return Left(Failure(errMessage: e.toString()));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, String>> retrieveAccessToken() async {
    try {
      final accessToken = await localDataSource.retrieveAccessToken();
      if (accessToken == null) {
        return Left(Failure(errMessage: "user token not found"));
      }
      return Right(accessToken);
    } catch (e) {
      return Left(Failure(errMessage: "Unexcpected Error occured"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> retrieveUser() async {
    try {
      log("retrieving user repo");
      final user = await localDataSource.retrieveUser();
      if (user == null) {
        return Left(Failure(errMessage: "user not found"));
      }
      return Right(user);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> logout() async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.logout();
        await localDataSource.deleteAccessToken();
        localDataSource.deleteUser();
        return Right(response);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      } catch (e) {
        return Left(Failure(errMessage: e.toString()));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}
