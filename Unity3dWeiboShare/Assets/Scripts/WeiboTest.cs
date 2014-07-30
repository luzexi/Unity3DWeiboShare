using UnityEngine;
using System.Collections;

public class WeiboTest : MonoBehaviour {

	// Use this for initialization
	void Start ()
	{
		WeiboShare.sInstance.Init();
	}
	
	// Update is called once per frame
	void Update () {
	
	}


	void OnGUI()
	{
		if(GUI.Button(new Rect(0,0,100,40) , "share"))
		{
			WeiboShare.sInstance.Share();
		}

		if(GUI.Button(new Rect(0,40,100,40),"Authorize"))
		{
			WeiboShare.sInstance.Authorize();
		}
	}
}
