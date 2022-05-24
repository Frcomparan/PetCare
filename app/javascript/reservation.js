const totalAmount = () => {
  const check_in = document.getElementById('reservation_check_in'),
        check_out = document.getElementById('reservation_check_out'),
        cost = document.getElementById('price').innerText,
        amount = document.getElementById('amount');

  let check_in_date = new Date(check_in.value),
      check_out_date = new Date(check_out.value);

  const diffTime = Math.abs(check_out_date - check_in_date);
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

  amount.innerText = "$" + cost * diffDays;
}

const updateRangeValue = () => {
  value = document.getElementById('myRange').value;
  document.getElementById('rangeValue').innerText = "Puntación: " + value;
}

window.onload = totalAmount();
