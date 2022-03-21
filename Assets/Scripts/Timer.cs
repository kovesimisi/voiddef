using System.Collections;
using System.Collections.Generic;
using UnityEngine;


//USEAGE: Give needed time, and function as parameter; time in seconds, function without "()"

public class Timer : MonoBehaviour
{
    [SerializeField] 
    float cDFrom = 0.0f; //countdown from

    [SerializeField]
    string functionToCall = "";
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (cDFrom > 0)
        {
            cDFrom -= Time.deltaTime;
        }
        else 
        {
            gameObject.SendMessage(functionToCall);
        }
    }
}
