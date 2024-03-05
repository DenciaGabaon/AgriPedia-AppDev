import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Dashboard.dart';
import 'package:logger/logger.dart';

//1. After Add Crop, ipapasa yung nakihang ID dito sa AnalysisPage.
//2. Then, yung irretrieve yung info galing sa database gamit yung ID
//3. declare variable na mag hohold sa na retrieve na ID (ID muna).
//4. display ID sa container. yung container is where you can edit the name. and
   //add planted date.
//5. if container/ button is clicked, then pass the ID sa dashboard.

//==============DASHBOARD PART================//
//1.  pag ka pasa ng ID, ilagay sa vriable lahat ng sensors using set state
//    after i retrieve.
//2.  then

//GOAL: to connect app to database using QR

String name = ''; // Initialize variables to hold the edited values
String date = '';

class Analysis extends StatefulWidget {
//  final String deviceID;
//  const Analysis({Key? key, this.deviceID}) : super(key: key);
  const Analysis({Key? key}) : super(key: key);


  @override
  State<Analysis> createState() => AnalysisState();

}

class CropData {
  late String devID;
  final String name;
  final String plantedDate;

  CropData({required this.devID, required this.name, required this.plantedDate});
}




class AnalysisState extends State<Analysis> {
  /*late String id;

  @override
  void initState() {
    super.initState();
    id = widget.deviceID;
    
    crops.add(CropData(devID: id, name: "Edit name", plantedDate: 'plantedDate'));

  }*/

   static List<CropData> crops = [
    //CropData(devID: 'Tomato Tornado 1', name: "online", plantedDate: "good"),
    //CropData(devID: "Tomato Tornado 2", name: "offline", plantedDate: "bad"),
  ];

  get id => null;

    static void addCropData(String id) {
      crops.add(CropData(devID: id, name: 'Edit name', plantedDate: 'plantedDate'));
  }





  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    var logger = Logger();
    logger.d(screenSize.height);
      //logger.d(CropData(devID: devID, name: name, plantedDate: plantedDate));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/Logo-appbar.svg',
              height: 30,
            ),
            const SizedBox(width: 8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
      ), //const Color.fromRGBO(245, 245, 219, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment(-0.8, 0.0),
                child:  Text('Live Analysis', style: TextStyle(
                  color: Color.fromRGBO(38, 50, 56, 1),
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  fontSize: 25,
                ),    textAlign: TextAlign.left, ),
              ),
              Container(
                  child:crops.isEmpty
                      ? Column(
                      children: [
                        SizedBox(height: screenSize.height/3,),
                        Center(
                            child: SizedBox(
                              width: 260,
                              child: Text(
                                'Connect to hardware using Add Crop button from Home page',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),)
                        )

                      ]
                  )
                      : Column(
                    children: [
                      Center(
                        child:  Column(
                          children: crops.map((crop)
                          {
                            return Column(
                              children: [

                                const Padding(padding: EdgeInsets.all(5.0)),
                                CropList(crop),
                              ],
                            );
                            // return getTask(crop);
                          }).toList(),
                        ),
                      )

                    ],
                  )
              )
            ],
          )
      ),
    );
  }

  Widget CropList(CropData crop){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 105, 46, 1),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: 365,
      height: 90,
      child: Row(
        children: [

          Image.asset('assets/Tomato.png'),
          SizedBox(width: 20,),
       
          InkWell(
            onTap: () {
            // Handle the click event here
            String scannedID = crop.devID;
            //int index = findIndexByStringID(crops, crop.devID);
            //String? id = crops[index].devID;
            //var logger =Logger();
            //logger.d("scannde: $scannedID");
            //logger.d("crop: ${crop.devID}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard(id: scannedID,)),
            );
          },
              child: Container(
                width: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 22,),
                    Text(
                      crop.devID,
                      style: const TextStyle(
                        color: Color.fromRGBO(220, 253, 146, 1),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),),

                    Text(
                      'Planted date: ',
                      style: const TextStyle(
                        color: Color.fromRGBO(220, 253, 146, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lato',
                        fontSize: 12,
                      ),),
                  ],
                ),
              ),),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomRight,
            child:Row(
              children:[
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Popupedit(crop.devID);

                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/Analysis-edit.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    var logger = Logger();
                    logger.d(crops);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Popuptrash(crop.devID);
                      },
                    );
                  },

                  child: SvgPicture.asset(
                    'assets/Analysis-trash.svg',
                    width: 16,
                    height: 16,
                  ),
                ),

              ]
            )
          )


         /* Align(
            alignment: Alignment.bottomRight,
            child:
          )*/


        ],
      ),
    );
  }

   int findIndexByStringID(List<CropData> crops, String id) {
     for (int i = 0; i < crops.length; i++) {
       if (crops[i].devID == id) {
         return i;
       }
     }
     return -1; // ID not found
   }

  Widget Popuptrash(String id){
    return
        AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                
                // Perform delete operation here
                int index = findIndexByStringID(crops, id);
                setState(() {
                  crops.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog and return true
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog and return false
              },
              child: Text('No'),
            ),
          ],
        );
  }
}


Widget Popupedit(String id){
  return AlertDialog(
    title: Text('Edit Crop Details'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Name your Crop',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        TextField(
          onChanged: (value) {
            name = value; // Update the 'name' variable when the text changes
          },
          decoration: InputDecoration(
            hintText: 'Enter a Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Date Planted',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        TextField(
          onChanged: (value) {
            date = value; // Update the 'date' variable when the text changes
          },
          decoration: InputDecoration(
            hintText: 'MM/DD/YYYY',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
    actions: [
      ElevatedButton(
        onPressed: () {
          // Perform save operation here
          print('Name: $name, Date: $date');
         // Navigator.of(context).pop(); // Close the dialog
        },
        child: Text('Save'),
      ),
      TextButton(
        onPressed: () {
       //   Navigator.of(context).pop(); // Close the dialog without saving
        },
        child: Text('Cancel'),
      ),
    ],
  );

}
