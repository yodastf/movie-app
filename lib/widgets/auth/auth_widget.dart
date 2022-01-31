



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';

class AuthWidget extends StatefulWidget{
  AuthWidget({Key? key}):super(key:key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();

}
class _AuthWidgetState extends State<AuthWidget>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Login to your account'),),
      body: ListView(
        children:[_HeaderWidget(),],
      ),
    );
  }
 
  }

 class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
            fontSize:15,
            color:Colors.black
          );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:25),
          _FormWidget(),
          SizedBox(height:25),
          Text('fdjfdsdfkldfklfdlklsfksdnfdslnflkasnflsanflknaslfknaslnflskafnlfkn l fnldfsnfslkd aklfdslkndfnf dalk fsknfs nkfklaslkfaklfa lfdsk nf laks nlasaldk llkdsa kadl dkkdl sdalkakl jfjdsfn dfsjkfnsjdnfndsjk njk fdsjkfn fj sjskfakjna;gjff;hothH I ;iofho;fa ',
          style:textStyle,
          ),
          SizedBox(height:5),
          MaterialButton(onPressed: () {},
            
            textColor: Colors.blue,
            child: Text(' Register',
            style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),
            ),),
          
          SizedBox(height:25),
          Text('fdjfdsdfkldfklfdlklsfksdnfdslnflkasnflsanflknaslfknaslnflskafnlfkn l fnldfsnfslkd aklfdslkndfnf dalk fsknfs nkf ',style: textStyle,
          ),
           SizedBox(height:5),
          MaterialButton(onPressed: () {},
            
            textColor: Colors.blue,
            child: Text(' Verify email',
            style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),
            ),),

        ],
        
      ),
    );
  }

}

class _FormWidget extends StatelessWidget {
  const _FormWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
     final textFieldDecorator = const InputDecoration(
     
      focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal:10,vertical:10),
      isCollapsed: true,
    );
    final textStyle = const TextStyle(
            fontSize:15,
            color:Colors.grey
          );
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       _ErrorMessageWidget(),
        Text('Username',style: textStyle,),
        SizedBox(height:5),
        TextField(
          controller: model?.loginTextController,
          decoration: textFieldDecorator,),
        SizedBox(height:25),
        Text('Password',style: textStyle,),
        SizedBox(height:5),
        TextField(
          controller: model?.passwordTextController,
          decoration:textFieldDecorator,
          obscureText:true,
          
        ),
         SizedBox(height:25),
        Row(
          children:[
            
            const _AuthButtonWidget(),
            SizedBox(width:30),
            MaterialButton(onPressed: null, 
          
            textColor: Colors.blue,
            child: Text('Reset Password',
            style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),
            ),),
           

          ]
        )
        
      ],
      
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
    
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed =model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true ? SizedBox(
      width: 15,
      height: 15, 
      child: CircularProgressIndicator(strokeWidth: 2,)) : const Text(
      'Login',style: TextStyle(fontSize:16,fontWeight: FontWeight.w700), );
    return MaterialButton(onPressed: onPressed,
    color: Colors.blue,
    textColor: Colors.white,
    
    child: child);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final errorMesasge = NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if(errorMesasge == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
            errorMesasge,
            style:TextStyle(color: Colors.red,fontSize: 17),
            ),
    );
  }
}


