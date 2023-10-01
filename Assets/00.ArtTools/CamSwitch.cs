using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamSwitch : MonoBehaviour
{
    public Camera[] Cams;

    public GameObject[] Targets;

    // Start is called before the first frame update
    void Start()
    {
        LastQuaternion = new Quaternion[Targets.Length];
        LastLightQuaternion = new Quaternion[Targets.Length];
    }

    private int index = 0;

    private Vector3 LastMousePosition;
    private Quaternion[] LastQuaternion;
    private Quaternion[] LastLightQuaternion;

    private bool isClick = false;
    
    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.RightArrow))
        {
            if (Cams.Length > 0)
            {
                index = (index + 1) % Cams.Length;

                for (int i = 0; i < Cams.Length; i++)
                {
                    if (i != index)
                    {
                        Cams[i].gameObject.SetActive(false);
                    }
                    else
                    {
                        Cams[i].gameObject.SetActive(true);
                    }
                }
                
            }
        }
        
        // if (Input.GetMouseButtonDown(0))
        // {
        //     LastMousePosition = Input.mousePosition;
        //
        //     for (int i = 0; i < Targets.Length; i++)
        //     {
        //         LastQuaternion[i] = Targets[i].transform.rotation;
        //     }
        //     isClick = true;
        // }
        //
        //
        // if (isClick)
        // {
        //     Vector3 offset = Input.mousePosition - LastMousePosition;
        //     
        //     for (int i = 0; i < Targets.Length; i++)
        //     {
        //         Targets[i].transform.rotation = LastQuaternion[i] * Quaternion.Euler(0,-offset.x,0);
        //     }
        // }
        //
        // if (Input.GetMouseButtonUp(0))
        // {
        //     isClick = false;
        //     LastMousePosition = Vector3.zero;
        //     
        //     for (int i = 0; i < Targets.Length; i++)
        //     {
        //         LastQuaternion[i] = Targets[i].transform.rotation;
        //     }
        // }
        //
    }
}
