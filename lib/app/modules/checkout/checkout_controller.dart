import 'package:annaluxstore/app/modules/buy/models/product_store_model.dart';
import 'package:annaluxstore/app/modules/checkout/models/checkout_model.dart';
import 'package:annaluxstore/app/modules/checkout/repositories/order_repository_interface.dart';

import 'package:annaluxstore/app/modules/profile/models/adress_model.dart';
import 'package:annaluxstore/app/modules/shared/auth/repositories/auth_interface.dart';
import 'package:annaluxstore/app/modules/shared/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

part 'checkout_controller.g.dart';

class CheckoutController = _CheckoutControllerBase with _$CheckoutController;

abstract class _CheckoutControllerBase with Store {
  final IOrderRepository _orderRepository;
  final IAuthRepository _authRepository;

  UserModel user;
  _CheckoutControllerBase(this._orderRepository, this._authRepository) {
    getUserInfos();
  }

  @observable
  double cardHeigth = 0;
  @observable
  String cardNumber = "";
  @observable
  String cardHolder = "";
  @observable
  String cardExp = "";
  @observable
  IconData iconCard = FontAwesomeIcons.minus;
  @observable
  double opacity = 0;
  @observable
  String btnMessage = "Checar cartão";
  @observable
  bool orderFinish = false;

  getUserInfos() async {
    user = await _authRepository.getUser();
  }

  createNewOrder(List<ProductModelStore> products) async {
    if (btnMessage == "Finalizar Pedido") {
      AdressModel adress = await _getUserAdress();
      if (adress != null && products != null) {
        var orderModel = CheckoutModel(
          userId: user.id,
          userName: user.name,
          userEmail: user.email,
          products: products,
          adress: adress,
          status: "",
          date: DateTime.now(),
        );
        orderFinish = await _orderRepository.createNewOrder(orderModel);
        Future.delayed(Duration(seconds: 2), () {
          Modular.to.popUntil(ModalRoute.withName("/home"));
        });
      }
    } else {
      return;
    }
  }

  Future<AdressModel> _getUserAdress() async {
    AdressModel adress;
    if (user != null) {
      var adressLoaded = await _orderRepository.getUserAdressInDatabase(user);
      if (adressLoaded != null) {
        adress = adressLoaded;
      }
    }

    return adress;
  }

  @action
  initCreditCard() {
    if (cardHeigth == 100) {
      cardHeigth = 200;
      btnMessage = "Finalizar Pedido";
      Future.delayed(Duration(milliseconds: 370), () {
        opacity = 1;
      });

      return;
    }
    if (cardHeigth == 200) return;

    Future.delayed(Duration(milliseconds: 250), () {
      opacity = 0;
      cardHeigth = 100;
    });
  }

  @action
  checkout({
    String cardNumber,
    String cardHolder,
    String expDate,
    String secCode,
  }) {
    this.cardNumber = cardNumber;
    this.cardHolder = cardHolder;
    this.cardExp = expDate;
    initCreditCard();
    if (cardNumber.startsWith("5")) {
      iconCard = FontAwesomeIcons.ccMastercard;
    } else if (cardNumber.startsWith("4")) {
      iconCard = FontAwesomeIcons.ccVisa;
    } else {
      iconCard = FontAwesomeIcons.times;
    }
  }

  @action
  hideAndShowCard() {
    if (cardHeigth == 100) {
      cardHeigth = 200;
      Future.delayed(Duration(milliseconds: 370), () {
        opacity = 1;
      });

      return;
    }
    Future.delayed(Duration(milliseconds: 250), () {
      opacity = 0;
      cardHeigth = 100;
    });
  }
}
