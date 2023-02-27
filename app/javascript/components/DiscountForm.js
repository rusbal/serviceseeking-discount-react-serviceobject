import React, { useState } from 'react'
import axios from 'axios'

export default () => {
  const [sku, setSku] = useState()
  const [price, setPrice] = useState()
  const [quantity, setQuantity] = useState()
  const [message, setMessage] = useState()

  const handleSubmit = evt => {
    evt.preventDefault();

    if (sku === undefined || sku.trim() == '') {
      alert("SKU is required")
      return
    }
    if (price === undefined || parseFloat(price) <= 0) {
      alert("Price must be greater than zero")
      return
    }
    if (quantity === undefined || parseInt(quantity) <= 0) {
      alert("Quantity must be greater than zero")
      return
    }

    const inputData = {
      items: [
        { sku, price, quantity }
      ]
    }

    postData('http://localhost:3000/orders', inputData).then(data => {
      console.log(data)
    });
  }

  async function postData(url = "", data = {}) {
    axios.post(url, data)
      .then(function (res) {
        setMessage(`Success: ${res.data.message}`)
      })
      .catch(function (err) {
        setMessage(`Error: ${err.message}`)
      })
  }

  return (
    <div>
      <div>{ message }</div>
      <form onSubmit={e => {handleSubmit(e)}}>
        <input type="text" placeholder="sku" onChange={e => setSku(e.target.value)} />
        <input type="number" step="0.01" placeholder="price" onChange={e => setPrice(e.target.value)} />
        <input type="number" placeholder="quantity" onChange={e => setQuantity(e.target.value)} />
        <input type="submit" value="Submit" />
      </form>
    </div>
  )
}
