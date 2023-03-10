using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CjStates : MonoBehaviour
{
    enum State: byte {//Entero que no supera los 8 bits o datos.
        Bounce, Float, Expand // 0, 1, 2.
    }

    [SerializeField] private State currentState;
    [SerializeField] private Material mMaterial;
    [SerializeField] Color floatingColor;
    [SerializeField] Color normalColor;
    Rigidbody mrigidbody;

    private void Awake() {
        mrigidbody = GetComponent<Rigidbody>();
    }
    void Update() {

        if (currentState == State.Bounce) {

            if (Input.GetKeyDown(KeyCode.Space)) {
                currentState = State.Float;
                mrigidbody.isKinematic = true;
                mMaterial.SetColor("_BaseColor", floatingColor);
            }

            if (Input.GetKeyDown(KeyCode.E)) {
                currentState = State.Expand;
                transform.localScale = Vector3.one * 5; //Expandir escalando en todos los ejes
            }
        }

        else {
            if (currentState == State.Float && Input.GetKeyUp(KeyCode.Space)) {
                currentState = State.Bounce;
                mrigidbody.isKinematic = false;
                mMaterial.SetColor("_BaseColor", normalColor);
            }

            if (currentState == State.Expand && Input.GetKeyUp(KeyCode.E)) {
                currentState = State.Bounce;
                transform.localScale = Vector3.one;
            }
        }
    }
}
