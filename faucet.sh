curl -X POST \
  -H "Content-Type: application/json" \
  -H "Origin: https://testnet.monad.xyz" \
  -H "X-Request-Verification-Token: 899a39d2c33e416bb839d7179e05256d3cd89060bcd3283c91732f10f5b5d342" \
  -H "X-Request-Timestamp: $(date +%s)" \
  -d '{
    "address": "0x0fe3959A2198EE6D696DA07C7e1c24a38c758154",
    "visitorId": "4573fa26bd39e5a4bf8642fa4f5e7e11",
    "cloudFlareResponseToken": "0.GoPrvCwcUvPCdIgs0xbbXA1IGGWMYnAraA3P7xFkIVu1eh0EiylfblzsJApyrtvBo1QQtq3QCwm-Xl5436p_nXljFgUmk-PsgfLx1K9f4F3sudFgDsh04M0i901Wpui81vG-2zphuRvlzhiA3DcDWQImSQkUUXFTba3LFTY3adJ9xwk_ogqLo9JKxKaboemKlFij7t0QpORwWYtromDCyj1FB7492xNgngtB_sZY5QdGMLBPlkbryDsdN5J_uLOQYUpFE3RxfG-0HhsW4hBtWDKFmRwJzC8bJhgNWqAyn5gGhDxwzs3p3Q7U7RV3pNAQuHDdJ-cjPhTochXQCl_UJ52bX433nzdxnA-9ON5Me-Ajw3cIGGLyr9ni-QDdEA0cje1F16xhzVak6yKKlubSQR3kIIpUB4pRsxrdw7bGMJs9zlwNRczWngoqIjd3Wu2npyPypOa6jtE22OwNKEpgrYZPgY5QAviNietTsy4JewO6TyN6gnLYdZLWzCN2ddKdQf6TOPJLW5luGZOY_ND9n1KzyTSHyhlLB6yYF2ilp5OOa3z1bDW2MEFCbn6GHL3Q7Iu7-Ud1h1sfxQloZC7BWGYI57dvdBcFJFdSOTBhYqQ2FgUhzv8VXCwK7LCwUsd0QreqQM_08k6Al924-MEotwRI3cEgrKf4BuKtVl2hrsfUdlHy4UCs-8C8Doe1B5sgabinaXDkVVXXIOKK-7Ph43ZUfIWaRhyZFk11gxMFCFER2Fl_4yjMPjSmgwSVLzohqXzDfcYVufJoi0TJKvRgfwzbMHHWJqiCLCkUUBRGFrPRNKuox7Xe3iPfonn_ApBk_E_W52ON0oS8WLLIRJ8sW09teM_F1RS_09WzJUln4Js.2-BOZEq3_kPxvnCWLu0xCg.899a39d2c33e416bb839d7179e05256d3cd89060bcd3283c91732f10f5b5d342"
  }' \
  https://faucet-claim-2.monadinfra.com
