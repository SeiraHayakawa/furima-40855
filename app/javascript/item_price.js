function item_price (){
  const priceInput = document.getElementById("item-price");
  const taxPriceDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");
  
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;
  
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = tax
  
    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = profit
  
  })

};


window.addEventListener('turbo:load', item_price);
window.addEventListener('turbo:render', item_price);