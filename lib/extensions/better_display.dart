extension BetterDisplay on String {
  String capitalizeFirstLetter() {
    if (isEmpty){
       return this;
       }
    return this[0].toUpperCase() + substring(1);
  }

  
  String extractYear(){
    if(isEmpty || length < 4){
      return this;
    }
    return substring(0, 4);
  }
}

