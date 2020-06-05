validateTextFieldWithHint(self.mainView.smsTextField) //1 passo


// 2 passo


fileprivate func validateTextFieldWithHint(_ textField: UITextField) {
        if textField == self.mainView.emailTextField {
            var hintText = ICLocalizedBundle.digitalBillingSubscribeInvalidEmail.localize()
            
            if textField.text == "" {
                hintText = ICLocalizedBundle.digitalBillingSubscribeEmptyField.localize()
                isValidEmail = false
            }
            
            showHintIfInvalidField(hintView: &self.mainView.hintView,
                                   yPosition: -125,
                                   isValid: isValidEmail,
                                   hintText: hintText,
                                   textField: textField)
        } else {
            var hintText = ICLocalizedBundle.digitalBillingSubscribeInvalidSMS.localize()
            
            if textField.text == "" {
                hintText = ICLocalizedBundle.digitalBillingSubscribeEmptyField.localize()
                isValidPhone = false
            }
            
            showHintIfInvalidField(hintView: &self.mainView.hintView,
                                   yPosition: -50,
                                   isValid: isValidPhone,
                                   hintText: hintText,
                                   textField: textField)
        }
        setButtonTextColor()
    }


// 3passo

   fileprivate func showHintIfInvalidField(hintView: inout ICHintView?, yPosition: Int, isValid: Bool, hintText: String, textField: UITextField) {
        if !isValid {
            if let materialTextField = textField as? ICMaterialTextField {
                materialTextField.defaultColor = UIColor.ICPurpleTextColor()
                materialTextField.textColor = UIColor.ICPurpleTextColor()
            }
            let width = self.mainView.textFormBackground.frame.width
            let frame = CGRect(x: 0, y: yPosition, width: Int(width), height: 0)
            let text = hintText
            if hintView != nil {
                hintView?.dismissHint(animated: true)
            }
            hintView = ICHintView.show(view:  self.mainView.separatorView, frame: frame, text: text, arrowDirection: .bottomLeft, tapShouldClose: true, hintColor: UIColor.ICWarning(), duration: kDuration, delegate: self)
            
            self.showInvalidSeparator(with: textField)
            trackAnalyticError(withMessage: hintText)
            
        } else if hintView != nil {
            hintView?.dismissHint(animated: true)
        }
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, hintView)
    }