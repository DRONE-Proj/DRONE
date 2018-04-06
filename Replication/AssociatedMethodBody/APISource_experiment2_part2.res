Number 1:
API Relative Path:
src.android.accounts.AccountManager.java-addAccountAsUser(String-String-String[]-Bundle-Activity-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @see #addAccount(String, String, String[], Bundle, Activity, AccountManagerCallback, Handler)
     * @hide
     */
    public AccountManagerFuture<Bundle> addAccountAsUser(final String accountType,
            final String authTokenType, final String[] requiredFeatures,
            final Bundle addAccountOptions, final Activity activity,
            AccountManagerCallback<Bundle> callback, Handler handler, final UserHandle userHandle) {
        if (accountType == null) throw new IllegalArgumentException("accountType is null");
        if (userHandle == null) throw new IllegalArgumentException("userHandle is null");
        final Bundle optionsIn = new Bundle();
        if (addAccountOptions != null) {
            optionsIn.putAll(addAccountOptions);
        }
        optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, mContext.getPackageName());

        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.addAccountAsUser(mResponse, accountType, authTokenType,
                        requiredFeatures, activity != null, optionsIn, userHandle.getIdentifier());
            }
        }.start();
    }


Number 2:
API Relative Path:
src.android.accounts.AccountManager.java-addAccountAsUser(String-String-String[]-Bundle-Activity-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @see #addAccount(String, String, String[], Bundle, Activity, AccountManagerCallback, Handler)
     * @hide
     */
    public AccountManagerFuture<Bundle> addAccountAsUser(final String accountType,
            final String authTokenType, final String[] requiredFeatures,
            final Bundle addAccountOptions, final Activity activity,
            AccountManagerCallback<Bundle> callback, Handler handler, final UserHandle userHandle) {
        if (accountType == null) throw new IllegalArgumentException("accountType is null");
        if (userHandle == null) throw new IllegalArgumentException("userHandle is null");
        final Bundle optionsIn = new Bundle();
        if (addAccountOptions != null) {
            optionsIn.putAll(addAccountOptions);
        }
        optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, mContext.getPackageName());

        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.addAccountAsUser(mResponse, accountType, authTokenType,
                        requiredFeatures, activity != null, optionsIn, userHandle.getIdentifier());
            }
        }.start();
    }


Number 3:
API Relative Path:
src.android.accounts.AccountManager.java-addAccountExplicitly(Account-String-Bundle)
Corresponding Source:
/**
     * Adds an account directly to the AccountManager. Normally used by sign-up
     * wizards associated with authenticators, not directly by applications.
     * <p>Calling this method does not update the last authenticated timestamp,
     * referred by {@link #KEY_LAST_AUTHENTICATED_TIME}. To update it, call
     * {@link #notifyAccountAuthenticated(Account)} after getting success.
     * However, if this method is called when it is triggered by addAccount() or
     * addAccountAsUser() or similar functions, then there is no need to update
     * timestamp manually as it is updated automatically by framework on
     * successful completion of the mentioned functions.
     * <p>It is safe to call this method from the main thread.
     * <p>This method requires the caller to have a signature match with the
     * authenticator that owns the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission is needed for those platforms. See docs
     * for this function in API level 22.
     *
     * @param account The {@link Account} to add
     * @param password The password to associate with the account, null for none
     * @param userdata String values to use for the account's userdata, null for
     *            none
     * @return True if the account was successfully added, false if the account
     *         already exists, the account is null, or another error occurs.
     */
    public boolean addAccountExplicitly(Account account, String password, Bundle userdata) {
        if (account == null) throw new IllegalArgumentException("account is null");
        try {
            return mService.addAccountExplicitly(account, password, userdata);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 4:
API Relative Path:
src.android.accounts.AccountManager.java-blockingGetAuthToken(Account-String-boolean)
Corresponding Source:
/**
     * This convenience helper synchronously gets an auth token with
     * {@link #getAuthToken(Account, String, boolean, AccountManagerCallback, Handler)}.
     *
     * <p>This method may block while a network request completes, and must
     * never be made from the main thread.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * USE_CREDENTIALS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The account to fetch an auth token for
     * @param authTokenType The auth token type, see {@link #getAuthToken getAuthToken()}
     * @param notifyAuthFailure If true, display a notification and return null
     *     if authentication fails; if false, prompt and wait for the user to
     *     re-enter correct credentials before returning
     * @return An auth token of the specified type for this account, or null
     *     if authentication fails or none can be fetched.
     * @throws AuthenticatorException if the authenticator failed to respond
     * @throws OperationCanceledException if the request was canceled for any
     *     reason, including the user canceling a credential request
     * @throws java.io.IOException if the authenticator experienced an I/O problem
     *     creating a new auth token, usually because of network trouble
     */
    public String blockingGetAuthToken(Account account, String authTokenType,
            boolean notifyAuthFailure)
            throws OperationCanceledException, IOException, AuthenticatorException {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (authTokenType == null) throw new IllegalArgumentException("authTokenType is null");
        Bundle bundle = getAuthToken(account, authTokenType, notifyAuthFailure, null /* callback */,
                null /* handler */).getResult();
        if (bundle == null) {
            // This should never happen, but it does, occasionally. If it does return null to
            // signify that we were not able to get the authtoken.
            // TODO: remove this when the bug is found that sometimes causes a null bundle to be
            // returned
            Log.e(TAG, "blockingGetAuthToken: null was returned from getResult() for "
                    + account + ", authTokenType " + authTokenType);
            return null;
        }
        return bundle.getString(KEY_AUTHTOKEN);
    }


Number 5:
API Relative Path:
src.android.accounts.AccountManager.java-blockingGetAuthToken(Account-String-boolean)
Corresponding Source:
/**
     * This convenience helper synchronously gets an auth token with
     * {@link #getAuthToken(Account, String, boolean, AccountManagerCallback, Handler)}.
     *
     * <p>This method may block while a network request completes, and must
     * never be made from the main thread.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * USE_CREDENTIALS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The account to fetch an auth token for
     * @param authTokenType The auth token type, see {@link #getAuthToken getAuthToken()}
     * @param notifyAuthFailure If true, display a notification and return null
     *     if authentication fails; if false, prompt and wait for the user to
     *     re-enter correct credentials before returning
     * @return An auth token of the specified type for this account, or null
     *     if authentication fails or none can be fetched.
     * @throws AuthenticatorException if the authenticator failed to respond
     * @throws OperationCanceledException if the request was canceled for any
     *     reason, including the user canceling a credential request
     * @throws java.io.IOException if the authenticator experienced an I/O problem
     *     creating a new auth token, usually because of network trouble
     */
    public String blockingGetAuthToken(Account account, String authTokenType,
            boolean notifyAuthFailure)
            throws OperationCanceledException, IOException, AuthenticatorException {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (authTokenType == null) throw new IllegalArgumentException("authTokenType is null");
        Bundle bundle = getAuthToken(account, authTokenType, notifyAuthFailure, null /* callback */,
                null /* handler */).getResult();
        if (bundle == null) {
            // This should never happen, but it does, occasionally. If it does return null to
            // signify that we were not able to get the authtoken.
            // TODO: remove this when the bug is found that sometimes causes a null bundle to be
            // returned
            Log.e(TAG, "blockingGetAuthToken: null was returned from getResult() for "
                    + account + ", authTokenType " + authTokenType);
            return null;
        }
        return bundle.getString(KEY_AUTHTOKEN);
    }


Number 6:
API Relative Path:
src.android.accounts.AccountManager.java-clearPassword(Account)
Corresponding Source:
/**
     * Forgets a saved password.  This erases the local copy of the password;
     * it does not change the user's account password on the server.
     * Has the same effect as setPassword(account, null) but requires fewer
     * permissions, and may be used by applications or management interfaces
     * to "sign out" from an account.
     *
     * <p>This method only successfully clear the account's password when the
     * caller has the same signature as the authenticator that owns the
     * specified account. Otherwise, this method will silently fail.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * MANAGE_ACCOUNTS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The account whose password to clear
     */
    public void clearPassword(final Account account) {
        if (account == null) throw new IllegalArgumentException("account is null");
        try {
            mService.clearPassword(account);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 7:
API Relative Path:
src.android.accounts.AccountManager.java-confirmCredentialsAsUser(Account-Bundle-Activity-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @hide
     * Same as {@link #confirmCredentials(Account, Bundle, Activity, AccountManagerCallback, Handler)}
     * but for the specified user.
     */
    public AccountManagerFuture<Bundle> confirmCredentialsAsUser(final Account account,
            final Bundle options,
            final Activity activity,
            final AccountManagerCallback<Bundle> callback,
            final Handler handler, UserHandle userHandle) {
        if (account == null) throw new IllegalArgumentException("account is null");
        final int userId = userHandle.getIdentifier();
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.confirmCredentialsAsUser(mResponse, account, options, activity != null,
                        userId);
            }
        }.start();
    }


Number 8:
API Relative Path:
src.android.accounts.AccountManager.java-copyAccountToUser(Account-UserHandle-UserHandle-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Copies an account from one user to another user.
     * @param account the account to copy
     * @param fromUser the user to copy the account from
     * @param toUser the target user
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Boolean indicated wether it
     * succeeded.
     * @hide
     */
    public AccountManagerFuture<Boolean> copyAccountToUser(
            final Account account, final UserHandle fromUser, final UserHandle toUser,
            AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (toUser == null || fromUser == null) {
            throw new IllegalArgumentException("fromUser and toUser cannot be null");
        }

        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.copyAccountToUser(
                        mResponse, account, fromUser.getIdentifier(), toUser.getIdentifier());
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 9:
API Relative Path:
src.android.accounts.AccountManager.java-copyAccountToUser(Account-UserHandle-UserHandle-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Copies an account from one user to another user.
     * @param account the account to copy
     * @param fromUser the user to copy the account from
     * @param toUser the target user
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Boolean indicated wether it
     * succeeded.
     * @hide
     */
    public AccountManagerFuture<Boolean> copyAccountToUser(
            final Account account, final UserHandle fromUser, final UserHandle toUser,
            AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (toUser == null || fromUser == null) {
            throw new IllegalArgumentException("fromUser and toUser cannot be null");
        }

        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.copyAccountToUser(
                        mResponse, account, fromUser.getIdentifier(), toUser.getIdentifier());
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 10:
API Relative Path:
src.android.accounts.AccountManager.java-editProperties(String-Activity-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Offers the user an opportunity to change an authenticator's settings.
     * These properties are for the authenticator in general, not a particular
     * account.  Not all authenticators support this method.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * <p>This method requires the caller to have the same signature as the
     * authenticator associated with the specified account type.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * MANAGE_ACCOUNTS permission is needed for those platforms. See docs
     * for this function in API level 22.
     *
     * @param accountType The account type associated with the authenticator
     *     to adjust
     * @param activity The {@link Activity} context to use for launching a new
     *     authenticator-defined sub-Activity to adjust authenticator settings;
     *     used only to call startActivity(); if null, the settings dialog will
     *     not be launched directly, but the necessary {@link Intent} will be
     *     returned to the caller instead
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Bundle
     *     which is empty if properties were edited successfully, or
     *     if no activity was specified, contains only {@link #KEY_INTENT}
     *     needed to launch the authenticator's settings dialog.
     *     If an error occurred, {@link AccountManagerFuture#getResult()}
     *     throws:
     * <ul>
     * <li> {@link AuthenticatorException} if no authenticator was registered for
     *      this account type or the authenticator failed to respond
     * <li> {@link OperationCanceledException} if the operation was canceled for
     *      any reason, including the user canceling the settings dialog
     * <li> {@link IOException} if the authenticator experienced an I/O problem
     *      updating settings, usually because of network trouble
     * </ul>
     */
    public AccountManagerFuture<Bundle> editProperties(final String accountType,
            final Activity activity, final AccountManagerCallback<Bundle> callback,
            final Handler handler) {
        if (accountType == null) throw new IllegalArgumentException("accountType is null");
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.editProperties(mResponse, accountType, activity != null);
            }
        }.start();
    }


Number 11:
API Relative Path:
src.android.accounts.AccountManager.java-finishSessionAsUser(Bundle-Activity-UserHandle-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * @see #finishSession
     * @hide
     */
    @SystemApi
    public AccountManagerFuture<Bundle> finishSessionAsUser(
            final Bundle sessionBundle,
            final Activity activity,
            final UserHandle userHandle,
            AccountManagerCallback<Bundle> callback,
            Handler handler) {
        if (sessionBundle == null) {
            throw new IllegalArgumentException("sessionBundle is null");
        }

        /* Add information required by add account flow */
        final Bundle appInfo = new Bundle();
        appInfo.putString(KEY_ANDROID_PACKAGE_NAME, mContext.getPackageName());

        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.finishSessionAsUser(
                        mResponse,
                        sessionBundle,
                        activity != null,
                        appInfo,
                        userHandle.getIdentifier());
            }
        }.start();
    }


Number 12:
API Relative Path:
src.android.accounts.AccountManager.java-get(Context)
Corresponding Source:
/**
     * Gets an AccountManager instance associated with a Context.
     * The {@link Context} will be used as long as the AccountManager is
     * active, so make sure to use a {@link Context} whose lifetime is
     * commensurate with any listeners registered to
     * {@link #addOnAccountsUpdatedListener} or similar methods.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p>No permission is required to call this method.
     *
     * @param context The {@link Context} to use when necessary
     * @return An {@link AccountManager} instance
     */
    public static AccountManager get(Context context) {
        if (context == null) throw new IllegalArgumentException("context is null");
        return (AccountManager) context.getSystemService(Context.ACCOUNT_SERVICE);
    }


Number 13:
API Relative Path:
src.android.accounts.AccountManager.java-getAuthToken(Account-String-Bundle-Activity-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Gets an auth token of the specified type for a particular account,
     * prompting the user for credentials if necessary.  This method is
     * intended for applications running in the foreground where it makes
     * sense to ask the user directly for a password.
     *
     * <p>If a previously generated auth token is cached for this account and
     * type, then it is returned.  Otherwise, if a saved password is
     * available, it is sent to the server to generate a new auth token.
     * Otherwise, the user is prompted to enter a password.
     *
     * <p>Some authenticators have auth token <em>types</em>, whose value
     * is authenticator-dependent.  Some services use different token types to
     * access different functionality -- for example, Google uses different auth
     * tokens to access Gmail and Google Calendar for the same account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * USE_CREDENTIALS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * @param account The account to fetch an auth token for
     * @param authTokenType The auth token type, an authenticator-dependent
     *     string token, must not be null
     * @param options Authenticator-specific options for the request,
     *     may be null or empty
     * @param activity The {@link Activity} context to use for launching a new
     *     authenticator-defined sub-Activity to prompt the user for a password
     *     if necessary; used only to call startActivity(); must not be null.
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Bundle with
     *     at least the following fields:
     * <ul>
     * <li> {@link #KEY_ACCOUNT_NAME} - the name of the account you supplied
     * <li> {@link #KEY_ACCOUNT_TYPE} - the type of the account
     * <li> {@link #KEY_AUTHTOKEN} - the auth token you wanted
     * </ul>
     *
     * (Other authenticator-specific values may be returned.)  If an auth token
     * could not be fetched, {@link AccountManagerFuture#getResult()} throws:
     * <ul>
     * <li> {@link AuthenticatorException} if the authenticator failed to respond
     * <li> {@link OperationCanceledException} if the operation is canceled for
     *      any reason, incluidng the user canceling a credential request
     * <li> {@link IOException} if the authenticator experienced an I/O problem
     *      creating a new auth token, usually because of network trouble
     * </ul>
     * If the account is no longer present on the device, the return value is
     * authenticator-dependent.  The caller should verify the validity of the
     * account before requesting an auth token.
     */
    public AccountManagerFuture<Bundle> getAuthToken(
            final Account account, final String authTokenType, final Bundle options,
            final Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (authTokenType == null) throw new IllegalArgumentException("authTokenType is null");
        final Bundle optionsIn = new Bundle();
        if (options != null) {
            optionsIn.putAll(options);
        }
        optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, mContext.getPackageName());
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.getAuthToken(mResponse, account, authTokenType,
                        false /* notifyOnAuthFailure */, true /* expectActivityLaunch */,
                        optionsIn);
            }
        }.start();
    }


Number 14:
API Relative Path:
src.android.accounts.AccountManager.java-getAuthToken(Account-String-Bundle-boolean-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Gets an auth token of the specified type for a particular account,
     * optionally raising a notification if the user must enter credentials.
     * This method is intended for background tasks and services where the
     * user should not be immediately interrupted with a password prompt.
     *
     * <p>If a previously generated auth token is cached for this account and
     * type, then it is returned.  Otherwise, if a saved password is
     * available, it is sent to the server to generate a new auth token.
     * Otherwise, an {@link Intent} is returned which, when started, will
     * prompt the user for a password.  If the notifyAuthFailure parameter is
     * set, a status bar notification is also created with the same Intent,
     * alerting the user that they need to enter a password at some point.
     *
     * <p>In that case, you may need to wait until the user responds, which
     * could take hours or days or forever.  When the user does respond and
     * supply a new password, the account manager will broadcast the
     * {@link #LOGIN_ACCOUNTS_CHANGED_ACTION} Intent, which applications can
     * use to try again.
     *
     * <p>If notifyAuthFailure is not set, it is the application's
     * responsibility to launch the returned Intent at some point.
     * Either way, the result from this call will not wait for user action.
     *
     * <p>Some authenticators have auth token <em>types</em>, whose value
     * is authenticator-dependent.  Some services use different token types to
     * access different functionality -- for example, Google uses different auth
     * tokens to access Gmail and Google Calendar for the same account.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * USE_CREDENTIALS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The account to fetch an auth token for
     * @param authTokenType The auth token type, an authenticator-dependent
     *     string token, must not be null
     * @param options Authenticator-specific options for the request,
     *     may be null or empty
     * @param notifyAuthFailure True to add a notification to prompt the
     *     user for a password if necessary, false to leave that to the caller
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Bundle with
     *     at least the following fields on success:
     * <ul>
     * <li> {@link #KEY_ACCOUNT_NAME} - the name of the account you supplied
     * <li> {@link #KEY_ACCOUNT_TYPE} - the type of the account
     * <li> {@link #KEY_AUTHTOKEN} - the auth token you wanted
     * </ul>
     *
     * (Other authenticator-specific values may be returned.)  If the user
     * must enter credentials, the returned Bundle contains only
     * {@link #KEY_INTENT} with the {@link Intent} needed to launch a prompt.
     *
     * If an error occurred, {@link AccountManagerFuture#getResult()} throws:
     * <ul>
     * <li> {@link AuthenticatorException} if the authenticator failed to respond
     * <li> {@link OperationCanceledException} if the operation is canceled for
     *      any reason, incluidng the user canceling a credential request
     * <li> {@link IOException} if the authenticator experienced an I/O problem
     *      creating a new auth token, usually because of network trouble
     * </ul>
     * If the account is no longer present on the device, the return value is
     * authenticator-dependent.  The caller should verify the validity of the
     * account before requesting an auth token.
     */
    public AccountManagerFuture<Bundle> getAuthToken(
            final Account account, final String authTokenType, final Bundle options,
            final boolean notifyAuthFailure,
            AccountManagerCallback<Bundle> callback, Handler handler) {

        if (account == null) throw new IllegalArgumentException("account is null");
        if (authTokenType == null) throw new IllegalArgumentException("authTokenType is null");
        final Bundle optionsIn = new Bundle();
        if (options != null) {
            optionsIn.putAll(options);
        }
        optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, mContext.getPackageName());
        return new AmsTask(null, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.getAuthToken(mResponse, account, authTokenType,
                        notifyAuthFailure, false /* expectActivityLaunch */, optionsIn);
            }
        }.start();
    }


Number 15:
API Relative Path:
src.android.accounts.AccountManager.java-getPreviousName(Account)
Corresponding Source:
/**
     * Gets the previous name associated with the account or {@code null}, if
     * none. This is intended so that clients of {@link
     * #LOGIN_ACCOUNTS_CHANGED_ACTION} broadcasts can determine if an
     * authenticator has renamed an account.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * @param account The account to query for a previous name.
     * @return The account's previous name, null if the account has never been
     *         renamed.
     */
    public String getPreviousName(final Account account) {
        if (account == null) throw new IllegalArgumentException("account is null");
        try {
            return mService.getPreviousName(account);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 16:
API Relative Path:
src.android.accounts.AccountManager.java-getUserData(Account-String)
Corresponding Source:
/**
     * Gets the user data named by "key" associated with the account.
     * This is intended for authenticators and related code to store
     * arbitrary metadata along with accounts.  The meaning of the keys
     * and values is up to the authenticator for the account.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that owns the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission is needed for those platforms. See docs
     * for this function in API level 22.
     *
     * @param account The account to query for user data
     * @return The user data, null if the account or key doesn't exist
     */
    public String getUserData(final Account account, final String key) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (key == null) throw new IllegalArgumentException("key is null");
        try {
            return mService.getUserData(account, key);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 17:
API Relative Path:
src.android.accounts.AccountManager.java-getUserData(Account-String)
Corresponding Source:
/**
     * Gets the user data named by "key" associated with the account.
     * This is intended for authenticators and related code to store
     * arbitrary metadata along with accounts.  The meaning of the keys
     * and values is up to the authenticator for the account.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that owns the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission is needed for those platforms. See docs
     * for this function in API level 22.
     *
     * @param account The account to query for user data
     * @return The user data, null if the account or key doesn't exist
     */
    public String getUserData(final Account account, final String key) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (key == null) throw new IllegalArgumentException("key is null");
        try {
            return mService.getUserData(account, key);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 18:
API Relative Path:
src.android.accounts.AccountManager.java-hasFeatures(Account-String[]-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Finds out whether a particular account has all the specified features.
     * Account features are authenticator-specific string tokens identifying
     * boolean account properties.  For example, features are used to tell
     * whether Google accounts have a particular service (such as Google
     * Calendar or Google Talk) enabled.  The feature names and their meanings
     * are published somewhere associated with the authenticator in question.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * <p>This method requires the caller to hold the permission
     * {@link android.Manifest.permission#GET_ACCOUNTS} or be a signature
     * match with the AbstractAccountAuthenticator that manages the account.
     *
     * @param account The {@link Account} to test
     * @param features An array of the account features to check
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Boolean,
     * true if the account exists and has all of the specified features.
     */
    @RequiresPermission(GET_ACCOUNTS)
    public AccountManagerFuture<Boolean> hasFeatures(final Account account,
            final String[] features,
            AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (features == null) throw new IllegalArgumentException("features is null");
        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.hasFeatures(mResponse, account, features, mContext.getOpPackageName());
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 19:
API Relative Path:
src.android.accounts.AccountManager.java-hasFeatures(Account-String[]-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Finds out whether a particular account has all the specified features.
     * Account features are authenticator-specific string tokens identifying
     * boolean account properties.  For example, features are used to tell
     * whether Google accounts have a particular service (such as Google
     * Calendar or Google Talk) enabled.  The feature names and their meanings
     * are published somewhere associated with the authenticator in question.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * <p>This method requires the caller to hold the permission
     * {@link android.Manifest.permission#GET_ACCOUNTS} or be a signature
     * match with the AbstractAccountAuthenticator that manages the account.
     *
     * @param account The {@link Account} to test
     * @param features An array of the account features to check
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Boolean,
     * true if the account exists and has all of the specified features.
     */
    @RequiresPermission(GET_ACCOUNTS)
    public AccountManagerFuture<Boolean> hasFeatures(final Account account,
            final String[] features,
            AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (features == null) throw new IllegalArgumentException("features is null");
        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.hasFeatures(mResponse, account, features, mContext.getOpPackageName());
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 20:
API Relative Path:
src.android.accounts.AccountManager.java-isCredentialsUpdateSuggested(Account-String-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Checks whether {@link #updateCredentials} or {@link #startUpdateCredentialsSession} should be
     * called with respect to the specified account.
     * <p>
     * This method may be called from any thread, but the returned {@link AccountManagerFuture} must
     * not be used on the main thread.
     *
     * @param account The {@link Account} to be checked whether {@link #updateCredentials} or
     * {@link #startUpdateCredentialsSession} should be called
     * @param statusToken a String of token to check account staus
     * @param callback Callback to invoke when the request completes, null for no callback
     * @param handler {@link Handler} identifying the callback thread, null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Boolean, true if the credentials
     *         of the account should be updated.
     * @hide
     */
    @SystemApi
    public AccountManagerFuture<Boolean> isCredentialsUpdateSuggested(
            final Account account,
            final String statusToken,
            AccountManagerCallback<Boolean> callback,
            Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }

        if (TextUtils.isEmpty(statusToken)) {
            throw new IllegalArgumentException("status token is empty");
        }

        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.isCredentialsUpdateSuggested(
                        mResponse,
                        account,
                        statusToken);
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 21:
API Relative Path:
src.android.accounts.AccountManager.java-notifyAccountAuthenticated(Account)
Corresponding Source:
/**
     * Notifies the system that the account has just been authenticated. This
     * information may be used by other applications to verify the account. This
     * should be called only when the user has entered correct credentials for
     * the account.
     * <p>
     * It is not safe to call this method from the main thread. As such, call it
     * from another thread.
     * <p>This method requires the caller to have a signature match with the
     * authenticator that owns the specified account.
     *
     * @param account The {@link Account} to be updated.
     * @return boolean {@code true} if the authentication of the account has been successfully
     *         acknowledged. Otherwise {@code false}.
     */
    public boolean notifyAccountAuthenticated(Account account) {
        if (account == null)
            throw new IllegalArgumentException("account is null");
        try {
            return mService.accountAuthenticated(account);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 22:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccount(Account-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Removes an account from the AccountManager.  Does nothing if the account
     * does not exist.  Does not delete the account from the server.
     * The authenticator may have its own policies preventing account
     * deletion, in which case the account will not be deleted.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that manages the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * MANAGE_ACCOUNTS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The {@link Account} to remove
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Boolean,
     *     true if the account has been successfully removed
     * @deprecated use
     *     {@link #removeAccount(Account, Activity, AccountManagerCallback, Handler)}
     *     instead
     */
    @Deprecated
    public AccountManagerFuture<Boolean> removeAccount(final Account account,
            AccountManagerCallback<Boolean> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.removeAccount(mResponse, account, false);
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 23:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccount(Account-Activity-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Removes an account from the AccountManager. Does nothing if the account
     * does not exist.  Does not delete the account from the server.
     * The authenticator may have its own policies preventing account
     * deletion, in which case the account will not be deleted.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that manages the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * MANAGE_ACCOUNTS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The {@link Account} to remove
     * @param activity The {@link Activity} context to use for launching a new
     *     authenticator-defined sub-Activity to prompt the user to delete an
     *     account; used only to call startActivity(); if null, the prompt
     *     will not be launched directly, but the {@link Intent} may be
     *     returned to the caller instead
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Bundle with
     *     {@link #KEY_BOOLEAN_RESULT} if activity was specified and an account
     *     was removed or if active. If no activity was specified, the returned
     *     Bundle contains only {@link #KEY_INTENT} with the {@link Intent}
     *     needed to launch the actual account removal process, if authenticator
     *     needs the activity launch. If an error occurred,
     *     {@link AccountManagerFuture#getResult()} throws:
     * <ul>
     * <li> {@link AuthenticatorException} if no authenticator was registered for
     *      this account type or the authenticator failed to respond
     * <li> {@link OperationCanceledException} if the operation was canceled for
     *      any reason, including the user canceling the creation process or
     *      adding accounts (of this type) has been disabled by policy
     * </ul>
     */
    public AccountManagerFuture<Bundle> removeAccount(final Account account,
            final Activity activity, AccountManagerCallback<Bundle> callback, Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.removeAccount(mResponse, account, activity != null);
            }
        }.start();
    }


Number 24:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccountAsUser(Account-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @see #removeAccount(Account, AccountManagerCallback, Handler)
     * @hide
     * @deprecated use
     *     {@link #removeAccountAsUser(Account, Activity, AccountManagerCallback, Handler)}
     *     instead
     */
    @Deprecated
    public AccountManagerFuture<Boolean> removeAccountAsUser(final Account account,
            AccountManagerCallback<Boolean> callback, Handler handler,
            final UserHandle userHandle) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (userHandle == null) throw new IllegalArgumentException("userHandle is null");
        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.removeAccountAsUser(mResponse, account, false, userHandle.getIdentifier());
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 25:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccountAsUser(Account-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @see #removeAccount(Account, AccountManagerCallback, Handler)
     * @hide
     * @deprecated use
     *     {@link #removeAccountAsUser(Account, Activity, AccountManagerCallback, Handler)}
     *     instead
     */
    @Deprecated
    public AccountManagerFuture<Boolean> removeAccountAsUser(final Account account,
            AccountManagerCallback<Boolean> callback, Handler handler,
            final UserHandle userHandle) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (userHandle == null) throw new IllegalArgumentException("userHandle is null");
        return new Future2Task<Boolean>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.removeAccountAsUser(mResponse, account, false, userHandle.getIdentifier());
            }
            @Override
            public Boolean bundleToResult(Bundle bundle) throws AuthenticatorException {
                if (!bundle.containsKey(KEY_BOOLEAN_RESULT)) {
                    throw new AuthenticatorException("no result in response");
                }
                return bundle.getBoolean(KEY_BOOLEAN_RESULT);
            }
        }.start();
    }


Number 26:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccountAsUser(Account-Activity-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @see #removeAccount(Account, Activity, AccountManagerCallback, Handler)
     * @hide
     */
    public AccountManagerFuture<Bundle> removeAccountAsUser(final Account account,
            final Activity activity, AccountManagerCallback<Bundle> callback, Handler handler,
            final UserHandle userHandle) {
        if (account == null)
            throw new IllegalArgumentException("account is null");
        if (userHandle == null)
            throw new IllegalArgumentException("userHandle is null");
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.removeAccountAsUser(mResponse, account, activity != null,
                        userHandle.getIdentifier());
            }
        }.start();
    }


Number 27:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccountAsUser(Account-Activity-AccountManagerCallback-Handler-UserHandle)
Corresponding Source:
/**
     * @see #removeAccount(Account, Activity, AccountManagerCallback, Handler)
     * @hide
     */
    public AccountManagerFuture<Bundle> removeAccountAsUser(final Account account,
            final Activity activity, AccountManagerCallback<Bundle> callback, Handler handler,
            final UserHandle userHandle) {
        if (account == null)
            throw new IllegalArgumentException("account is null");
        if (userHandle == null)
            throw new IllegalArgumentException("userHandle is null");
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.removeAccountAsUser(mResponse, account, activity != null,
                        userHandle.getIdentifier());
            }
        }.start();
    }


Number 28:
API Relative Path:
src.android.accounts.AccountManager.java-removeAccountExplicitly(Account)
Corresponding Source:
/**
     * Removes an account directly. Normally used by authenticators, not
     * directly by applications. Does not delete the account from the server.
     * The authenticator may have its own policies preventing account deletion,
     * in which case the account will not be deleted.
     * <p>
     * It is safe to call this method from the main thread.
     * <p>This method requires the caller to have a signature match with the
     * authenticator that manages the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission and same UID as account's authenticator
     * is needed for those platforms. See docs for this function in API level 22.
     *
     * @param account The {@link Account} to delete.
     * @return True if the account was successfully deleted, false if the
     *         account did not exist, the account is null, or another error
     *         occurs.
     */
    public boolean removeAccountExplicitly(Account account) {
        if (account == null) throw new IllegalArgumentException("account is null");
        try {
            return mService.removeAccountExplicitly(account);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 29:
API Relative Path:
src.android.accounts.AccountManager.java-renameAccount(Account-String-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Rename the specified {@link Account}.  This is equivalent to removing
     * the existing account and adding a new renamed account with the old
     * account's user data.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that manages the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission and same UID as account's authenticator
     * is needed for those platforms. See docs for this function in API level 22.
     *
     * @param account The {@link Account} to rename
     * @param newName String name to be associated with the account.
     * @param callback Callback to invoke when the request completes, null for
     *     no callback
     * @param handler {@link Handler} identifying the callback thread, null for
     *     the main thread
     * @return An {@link AccountManagerFuture} which resolves to the Account
     *     after the name change. If successful the account's name will be the
     *     specified new name.
     */
    public AccountManagerFuture<Account> renameAccount(
            final Account account,
            @Size(min = 1) final String newName,
            AccountManagerCallback<Account> callback,
            Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null.");
        if (TextUtils.isEmpty(newName)) {
              throw new IllegalArgumentException("newName is empty or null.");
        }
        return new Future2Task<Account>(handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.renameAccount(mResponse, account, newName);
            }
            @Override
            public Account bundleToResult(Bundle bundle) throws AuthenticatorException {
                String name = bundle.getString(KEY_ACCOUNT_NAME);
                String type = bundle.getString(KEY_ACCOUNT_TYPE);
                return new Account(name, type);
            }
        }.start();
    }


Number 30:
API Relative Path:
src.android.accounts.AccountManager.java-setAuthToken(Account-String-String)
Corresponding Source:
/**
     * Adds an auth token to the AccountManager cache for an account.
     * If the account does not exist then this call has no effect.
     * Replaces any previous auth token for this account and auth token type.
     * Intended for use by the authenticator, not directly by applications.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that manages the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission and same UID as account's authenticator
     * is needed for those platforms. See docs for this function in API level 22.
     *
     * @param account The account to set an auth token for
     * @param authTokenType The type of the auth token, see {#getAuthToken}
     * @param authToken The auth token to add to the cache
     */
    public void setAuthToken(Account account, final String authTokenType, final String authToken) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (authTokenType == null) throw new IllegalArgumentException("authTokenType is null");
        try {
            mService.setAuthToken(account, authTokenType, authToken);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 31:
API Relative Path:
src.android.accounts.AccountManager.java-setAuthToken(Account-String-String)
Corresponding Source:
/**
     * Adds an auth token to the AccountManager cache for an account.
     * If the account does not exist then this call has no effect.
     * Replaces any previous auth token for this account and auth token type.
     * Intended for use by the authenticator, not directly by applications.
     *
     * <p>It is safe to call this method from the main thread.
     *
     * <p>This method requires the caller to have a signature match with the
     * authenticator that manages the specified account.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * AUTHENTICATE_ACCOUNTS permission and same UID as account's authenticator
     * is needed for those platforms. See docs for this function in API level 22.
     *
     * @param account The account to set an auth token for
     * @param authTokenType The type of the auth token, see {#getAuthToken}
     * @param authToken The auth token to add to the cache
     */
    public void setAuthToken(Account account, final String authTokenType, final String authToken) {
        if (account == null) throw new IllegalArgumentException("account is null");
        if (authTokenType == null) throw new IllegalArgumentException("authTokenType is null");
        try {
            mService.setAuthToken(account, authTokenType, authToken);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 32:
API Relative Path:
src.android.accounts.AccountManager.java-startUpdateCredentialsSession(Account-String-Bundle-Activity-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Asks the user to enter a new password for an account but not updating the
     * saved credentials for the account until {@link #finishSession} is called.
     * <p>
     * This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     * <p>
     * <b>NOTE:</b> The saved credentials for the account alone will not be
     * updated by calling this API alone. #finishSession should be called after
     * this to update local credentials
     *
     * @param account The account to update credentials for
     * @param authTokenType The credentials entered must allow an auth token of
     *            this type to be created (but no actual auth token is
     *            returned); may be null
     * @param options Authenticator-specific options for the request; may be
     *            null or empty
     * @param activity The {@link Activity} context to use for launching a new
     *            authenticator-defined sub-Activity to prompt the user to enter
     *            a password; used only to call startActivity(); if null, the
     *            prompt will not be launched directly, but the necessary
     *            {@link Intent} will be returned to the caller instead
     * @param callback Callback to invoke when the request completes, null for
     *            no callback
     * @param handler {@link Handler} identifying the callback thread, null for
     *            the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Bundle with
     *         these fields if an activity was supplied and user was
     *         successfully re-authenticated to the account:
     *         <ul>
     *         <li>{@link #KEY_ACCOUNT_SESSION_BUNDLE} - encrypted Bundle for
     *         updating the local credentials on device later.
     *         <li>{@link #KEY_PASSWORD} - optional, the password or password
     *         hash of the account
     *         <li>{@link #KEY_ACCOUNT_STATUS_TOKEN} - optional, token to check
     *         status of the account
     *         </ul>
     *         If no activity was specified, the returned Bundle contains
     *         {@link #KEY_INTENT} with the {@link Intent} needed to launch the
     *         password prompt. If an error occurred,
     *         {@link AccountManagerFuture#getResult()} throws:
     *         <ul>
     *         <li>{@link AuthenticatorException} if the authenticator failed to
     *         respond
     *         <li>{@link OperationCanceledException} if the operation was
     *         canceled for any reason, including the user canceling the
     *         password prompt
     *         <li>{@link IOException} if the authenticator experienced an I/O
     *         problem verifying the password, usually because of network
     *         trouble
     *         </ul>
     * @see #finishSession
     * @hide
     */
    @SystemApi
    public AccountManagerFuture<Bundle> startUpdateCredentialsSession(
            final Account account,
            final String authTokenType,
            final Bundle options,
            final Activity activity,
            final AccountManagerCallback<Bundle> callback,
            final Handler handler) {
        if (account == null) {
            throw new IllegalArgumentException("account is null");
        }

        // Always include the calling package name. This just makes life easier
        // down stream.
        final Bundle optionsIn = new Bundle();
        if (options != null) {
            optionsIn.putAll(options);
        }
        optionsIn.putString(KEY_ANDROID_PACKAGE_NAME, mContext.getPackageName());

        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.startUpdateCredentialsSession(
                        mResponse,
                        account,
                        authTokenType,
                        activity != null,
                        optionsIn);
            }
        }.start();
    }


Number 33:
API Relative Path:
src.android.accounts.AccountManager.java-updateCredentials(Account-String-Bundle-Activity-AccountManagerCallback-Handler)
Corresponding Source:
/**
     * Asks the user to enter a new password for an account, updating the
     * saved credentials for the account.  Normally this happens automatically
     * when the server rejects credentials during an auth token fetch, but this
     * can be invoked directly to ensure we have the correct credentials stored.
     *
     * <p>This method may be called from any thread, but the returned
     * {@link AccountManagerFuture} must not be used on the main thread.
     *
     * <p><b>NOTE:</b> If targeting your app to work on API level 22 and before,
     * MANAGE_ACCOUNTS permission is needed for those platforms. See docs for
     * this function in API level 22.
     *
     * @param account The account to update credentials for
     * @param authTokenType The credentials entered must allow an auth token
     *     of this type to be created (but no actual auth token is returned);
     *     may be null
     * @param options Authenticator-specific options for the request;
     *     may be null or empty
     * @param activity The {@link Activity} context to use for launching a new
     *     authenticator-defined sub-Activity to prompt the user to enter a
     *     password; used only to call startActivity(); if null, the prompt
     *     will not be launched directly, but the necessary {@link Intent}
     *     will be returned to the caller instead
     * @param callback Callback to invoke when the request completes,
     *     null for no callback
     * @param handler {@link Handler} identifying the callback thread,
     *     null for the main thread
     * @return An {@link AccountManagerFuture} which resolves to a Bundle
     *     with these fields if an activity was supplied and the account
     *     credentials were successfully updated:
     * <ul>
     * <li> {@link #KEY_ACCOUNT_NAME} - the name of the account
     * <li> {@link #KEY_ACCOUNT_TYPE} - the type of the account
     * </ul>
     *
     * If no activity was specified, the returned Bundle contains
     * {@link #KEY_INTENT} with the {@link Intent} needed to launch the
     * password prompt. If an error occurred,
     * {@link AccountManagerFuture#getResult()} throws:
     * <ul>
     * <li> {@link AuthenticatorException} if the authenticator failed to respond
     * <li> {@link OperationCanceledException} if the operation was canceled for
     *      any reason, including the user canceling the password prompt
     * <li> {@link IOException} if the authenticator experienced an I/O problem
     *      verifying the password, usually because of network trouble
     * </ul>
     */
    public AccountManagerFuture<Bundle> updateCredentials(final Account account,
            final String authTokenType,
            final Bundle options, final Activity activity,
            final AccountManagerCallback<Bundle> callback,
            final Handler handler) {
        if (account == null) throw new IllegalArgumentException("account is null");
        return new AmsTask(activity, handler, callback) {
            @Override
            public void doWork() throws RemoteException {
                mService.updateCredentials(mResponse, account, authTokenType, activity != null,
                        options);
            }
        }.start();
    }


Number 34:
API Relative Path:
src.android.accounts.AuthenticatorDescription.java-AuthenticatorDescription(String-String-int-int-int-int-boolean)
Corresponding Source:
/** A constructor for a full AuthenticatorDescription */
    public AuthenticatorDescription(String type, String packageName, int labelId, int iconId,
            int smallIconId, int prefId, boolean customTokens) {
        if (type == null) throw new IllegalArgumentException("type cannot be null");
        if (packageName == null) throw new IllegalArgumentException("packageName cannot be null");
        this.type = type;
        this.packageName = packageName;
        this.labelId = labelId;
        this.iconId = iconId;
        this.smallIconId = smallIconId;
        this.accountPreferencesId = prefId;
        this.customTokens = customTokens;
    }


Number 35:
API Relative Path:
src.android.accounts.AuthenticatorDescription.java-AuthenticatorDescription(String-String-int-int-int-int-boolean)
Corresponding Source:
/** A constructor for a full AuthenticatorDescription */
    public AuthenticatorDescription(String type, String packageName, int labelId, int iconId,
            int smallIconId, int prefId, boolean customTokens) {
        if (type == null) throw new IllegalArgumentException("type cannot be null");
        if (packageName == null) throw new IllegalArgumentException("packageName cannot be null");
        this.type = type;
        this.packageName = packageName;
        this.labelId = labelId;
        this.iconId = iconId;
        this.smallIconId = smallIconId;
        this.accountPreferencesId = prefId;
        this.customTokens = customTokens;
    }


Number 36:
API Relative Path:
src.android.accounts.AuthenticatorDescription.java-newKey(String)
Corresponding Source:
/**
     * A factory method for creating an AuthenticatorDescription that can be used as a key
     * to identify the authenticator by its type.
     */

    public static AuthenticatorDescription newKey(String type) {
        if (type == null) throw new IllegalArgumentException("type cannot be null");
        return new AuthenticatorDescription(type);
    }


Number 37:
API Relative Path:
src.android.bluetooth.BluetoothAdapter.java-BluetoothAdapter(IBluetoothManager)
Corresponding Source:
/**
     * Use {@link #getDefaultAdapter} to get the BluetoothAdapter instance.
     */
    BluetoothAdapter(IBluetoothManager managerService) {

        if (managerService == null) {
            throw new IllegalArgumentException("bluetooth manager service is null");
        }
        try {
            mServiceLock.writeLock().lock();
            mService = managerService.registerAdapter(mManagerCallback);
        } catch (RemoteException e) {
            Log.e(TAG, "", e);
        } finally {
            mServiceLock.writeLock().unlock();
        }
        mManagerService = managerService;
        mLeScanClients = new HashMap<LeScanCallback, ScanCallback>();
        mToken = new Binder();
    }


Number 38:
API Relative Path:
src.android.bluetooth.BluetoothAdapter.java-closeProfileProxy(int-BluetoothProfile)
Corresponding Source:
/**
     * Close the connection of the profile proxy to the Service.
     *
     * <p> Clients should call this when they are no longer using
     * the proxy obtained from {@link #getProfileProxy}.
     * Profile can be one of  {@link BluetoothProfile#HEALTH}, {@link BluetoothProfile#HEADSET} or
     * {@link BluetoothProfile#A2DP}
     *
     * @param profile
     * @param proxy Profile proxy object
     */
    public void closeProfileProxy(int profile, BluetoothProfile proxy) {
        if (proxy == null) return;

        switch (profile) {
            case BluetoothProfile.HEADSET:
                BluetoothHeadset headset = (BluetoothHeadset)proxy;
                headset.close();
                break;
            case BluetoothProfile.A2DP:
                BluetoothA2dp a2dp = (BluetoothA2dp)proxy;
                a2dp.close();
                break;
            case BluetoothProfile.A2DP_SINK:
                BluetoothA2dpSink a2dpSink = (BluetoothA2dpSink)proxy;
                a2dpSink.close();
                break;
            case BluetoothProfile.AVRCP_CONTROLLER:
                BluetoothAvrcpController avrcp = (BluetoothAvrcpController)proxy;
                avrcp.close();
                break;
            case BluetoothProfile.INPUT_DEVICE:
                BluetoothInputDevice iDev = (BluetoothInputDevice)proxy;
                iDev.close();
                break;
            case BluetoothProfile.PAN:
                BluetoothPan pan = (BluetoothPan)proxy;
                pan.close();
                break;
            case BluetoothProfile.HEALTH:
                BluetoothHealth health = (BluetoothHealth)proxy;
                health.close();
                break;
           case BluetoothProfile.GATT:
                BluetoothGatt gatt = (BluetoothGatt)proxy;
                gatt.close();
                break;
            case BluetoothProfile.GATT_SERVER:
                BluetoothGattServer gattServer = (BluetoothGattServer)proxy;
                gattServer.close();
                break;
            case BluetoothProfile.MAP:
                BluetoothMap map = (BluetoothMap)proxy;
                map.close();
                break;
            case BluetoothProfile.HEADSET_CLIENT:
                BluetoothHeadsetClient headsetClient = (BluetoothHeadsetClient)proxy;
                headsetClient.close();
                break;
            case BluetoothProfile.SAP:
                BluetoothSap sap = (BluetoothSap)proxy;
                sap.close();
                break;
            case BluetoothProfile.PBAP_CLIENT:
                BluetoothPbapClient pbapClient = (BluetoothPbapClient)proxy;
                pbapClient.close();
                break;
        }
    }


Number 39:
API Relative Path:
src.android.bluetooth.BluetoothAdapter.java-getRemoteDevice(byte[])
Corresponding Source:
/**
     * Get a {@link BluetoothDevice} object for the given Bluetooth hardware
     * address.
     * <p>Valid Bluetooth hardware addresses must be 6 bytes. This method
     * expects the address in network byte order (MSB first).
     * <p>A {@link BluetoothDevice} will always be returned for a valid
     * hardware address, even if this adapter has never seen that device.
     *
     * @param address Bluetooth MAC address (6 bytes)
     * @throws IllegalArgumentException if address is invalid
     */
    public BluetoothDevice getRemoteDevice(byte[] address) {
        if (address == null || address.length != 6) {
            throw new IllegalArgumentException("Bluetooth address must have 6 bytes");
        }
        return new BluetoothDevice(String.format(Locale.US, "%02X:%02X:%02X:%02X:%02X:%02X",
                address[0], address[1], address[2], address[3], address[4], address[5]));
    }


Number 40:
API Relative Path:
src.android.bluetooth.BluetoothAvrcpPlayerSettings.java-addSettingValue(int-int)
Corresponding Source:
/**
     * Add a setting value.
     *
     * The setting must be part of possible settings in {@link getSettings()}.
     * @param setting setting config.
     * @param value value for the setting.
     * @throws IllegalStateException if the setting is not supported.
     */
    public void addSettingValue(int setting, int value) {
        if ((setting & mSettings) == 0) {
            Log.e(TAG, "Setting not supported: " + setting + " " + mSettings);
            throw new IllegalStateException("Setting not supported: " + setting);
        }
        mSettingsValue.put(setting, value);
    }


Number 41:
API Relative Path:
src.android.bluetooth.BluetoothAvrcpPlayerSettings.java-getSettingValue(int)
Corresponding Source:
/**
     * Get a setting value.
     *
     * The setting must be part of possible settings in {@link getSettings()}.
     * @param setting setting config.
     * @return value value for the setting.
     * @throws IllegalStateException if the setting is not supported.
     */
    public int getSettingValue(int setting) {
        if ((setting & mSettings) == 0) {
            Log.e(TAG, "Setting not supported: " + setting + " " + mSettings);
            throw new IllegalStateException("Setting not supported: " + setting);
        }
        Integer i = mSettingsValue.get(setting);
        if (i == null) return -1;
        return i;
    }


Number 42:
API Relative Path:
src.android.bluetooth.BluetoothDevice.java-convertPinToBytes(String)
Corresponding Source:
/**
     * Check that a pin is valid and convert to byte array.
     *
     * Bluetooth pin's are 1 to 16 bytes of UTF-8 characters.
     * @param pin pin as java String
     * @return the pin code as a UTF-8 byte array, or null if it is an invalid
     *         Bluetooth pin.
     * @hide
     */
    public static byte[] convertPinToBytes(String pin) {
        if (pin == null) {
            return null;
        }
        byte[] pinBytes;
        try {
            pinBytes = pin.getBytes("UTF-8");
        } catch (UnsupportedEncodingException uee) {
            Log.e(TAG, "UTF-8 not supported?!?");  // this should not happen
            return null;
        }
        if (pinBytes.length <= 0 || pinBytes.length > 16) {
            return null;
        }
        return pinBytes;
    }


Number 43:
API Relative Path:
src.android.bluetooth.BluetoothDevice.java-createBond(int)
Corresponding Source:
/**
     * Start the bonding (pairing) process with the remote device using the
     * specified transport.
     *
     * <p>This is an asynchronous call, it will return immediately. Register
     * for {@link #ACTION_BOND_STATE_CHANGED} intents to be notified when
     * the bonding process completes, and its result.
     * <p>Android system services will handle the necessary user interactions
     * to confirm and complete the bonding process.
     * <p>Requires {@link android.Manifest.permission#BLUETOOTH_ADMIN}.
     *
     * @param transport The transport to use for the pairing procedure.
     * @return false on immediate error, true if bonding will begin
     * @throws IllegalArgumentException if an invalid transport was specified
     * @hide
     */
    public boolean createBond(int transport) {
        if (sService == null) {
            Log.e(TAG, "BT not enabled. Cannot create bond to Remote Device");
            return false;
        }
        if (TRANSPORT_AUTO > transport || transport > TRANSPORT_LE)
        {
            throw new IllegalArgumentException(transport + " is not a valid Bluetooth transport");
        }
        try {
            Log.i(TAG, "createBond() for device " + getAddress() +
                    " called by pid: " + Process.myPid() +
                    " tid: " + Process.myTid());
            return sService.createBond(this, transport);
        } catch (RemoteException e) {Log.e(TAG, "", e);}
        return false;
    }


Number 44:
API Relative Path:
src.android.bluetooth.BluetoothGatt.java-requestConnectionPriority(int)
Corresponding Source:
/**
     * Request a connection parameter update.
     *
     * <p>This function will send a connection parameter update request to the
     * remote device.
     *
     * @param connectionPriority Request a specific connection priority. Must be one of
     *          {@link BluetoothGatt#CONNECTION_PRIORITY_BALANCED},
     *          {@link BluetoothGatt#CONNECTION_PRIORITY_HIGH}
     *          or {@link BluetoothGatt#CONNECTION_PRIORITY_LOW_POWER}.
     * @throws IllegalArgumentException If the parameters are outside of their
     *                                  specified range.
     */
    public boolean requestConnectionPriority(int connectionPriority) {
        if (connectionPriority < CONNECTION_PRIORITY_BALANCED ||
            connectionPriority > CONNECTION_PRIORITY_LOW_POWER) {
            throw new IllegalArgumentException("connectionPriority not within valid range");
        }

        if (DBG) Log.d(TAG, "requestConnectionPriority() - params: " + connectionPriority);
        if (mService == null || mClientIf == 0) return false;

        try {
            mService.connectionParameterUpdate(mClientIf, mDevice.getAddress(), connectionPriority);
        } catch (RemoteException e) {
            Log.e(TAG,"",e);
            return false;
        }

        return true;
    }


Number 45:
API Relative Path:
src.android.bluetooth.BluetoothInputStream.java-read(byte[]-int-int)
Corresponding Source:
/**
     * Reads at most {@code length} bytes from this stream and stores them in
     * the byte array {@code b} starting at {@code offset}.
     *
     * @param b
     *            the byte array in which to store the bytes read.
     * @param offset
     *            the initial position in {@code buffer} to store the bytes
     *            read from this stream.
     * @param length
     *            the maximum number of bytes to store in {@code b}.
     * @return the number of bytes actually read or -1 if the end of the stream
     *         has been reached.
     * @throws IndexOutOfBoundsException
     *             if {@code offset < 0} or {@code length < 0}, or if
     *             {@code offset + length} is greater than the length of
     *             {@code b}.
     * @throws IOException
     *             if the stream is closed or another IOException occurs.
     * @since Android 1.5
     */
    public int read(byte[] b, int offset, int length) throws IOException {
        if (b == null) {
            throw new NullPointerException("byte array is null");
        }
        if ((offset | length) < 0 || length > b.length - offset) {
            throw new ArrayIndexOutOfBoundsException("invalid offset or length");
        }
        return mSocket.read(b, offset, length);
    }


Number 46:
API Relative Path:
src.android.bluetooth.BluetoothInputStream.java-read(byte[]-int-int)
Corresponding Source:
/**
     * Reads at most {@code length} bytes from this stream and stores them in
     * the byte array {@code b} starting at {@code offset}.
     *
     * @param b
     *            the byte array in which to store the bytes read.
     * @param offset
     *            the initial position in {@code buffer} to store the bytes
     *            read from this stream.
     * @param length
     *            the maximum number of bytes to store in {@code b}.
     * @return the number of bytes actually read or -1 if the end of the stream
     *         has been reached.
     * @throws IndexOutOfBoundsException
     *             if {@code offset < 0} or {@code length < 0}, or if
     *             {@code offset + length} is greater than the length of
     *             {@code b}.
     * @throws IOException
     *             if the stream is closed or another IOException occurs.
     * @since Android 1.5
     */
    public int read(byte[] b, int offset, int length) throws IOException {
        if (b == null) {
            throw new NullPointerException("byte array is null");
        }
        if ((offset | length) < 0 || length > b.length - offset) {
            throw new ArrayIndexOutOfBoundsException("invalid offset or length");
        }
        return mSocket.read(b, offset, length);
    }


Number 47:
API Relative Path:
src.android.bluetooth.BluetoothManager.java-BluetoothManager(Context)
Corresponding Source:
/**
     * @hide
     */
    public BluetoothManager(Context context) {
        context = context.getApplicationContext();
        if (context == null) {
            throw new IllegalArgumentException(
                    "context not associated with any application (using a mock context?)");
        }
        // Legacy api - getDefaultAdapter does not take in the context
        mAdapter = BluetoothAdapter.getDefaultAdapter();
    }


Number 48:
API Relative Path:
src.android.bluetooth.BluetoothManager.java-getConnectedDevices(int)
Corresponding Source:
/**
     * Get connected devices for the specified profile.
     *
     * <p> Return the set of devices which are in state {@link BluetoothProfile#STATE_CONNECTED}
     *
     * <p>This is not specific to any application configuration but represents
     * the connection state of Bluetooth for this profile.
     * This can be used by applications like status bar which would just like
     * to know the state of Bluetooth.
     *
     * <p>Requires {@link android.Manifest.permission#BLUETOOTH} permission.
     *
     * @param profile GATT or GATT_SERVER
     * @return List of devices. The list will be empty on error.
     */
    @RequiresPermission(Manifest.permission.BLUETOOTH)
    public List<BluetoothDevice> getConnectedDevices(int profile) {
        if (DBG) Log.d(TAG,"getConnectedDevices");
        if (profile != BluetoothProfile.GATT && profile != BluetoothProfile.GATT_SERVER) {
            throw new IllegalArgumentException("Profile not supported: " + profile);
        }

        List<BluetoothDevice> connectedDevices = new ArrayList<BluetoothDevice>();

        try {
            IBluetoothManager managerService = mAdapter.getBluetoothManager();
            IBluetoothGatt iGatt = managerService.getBluetoothGatt();
            if (iGatt == null) return connectedDevices;

            connectedDevices = iGatt.getDevicesMatchingConnectionStates(
                new int[] { BluetoothProfile.STATE_CONNECTED });
        } catch (RemoteException e) {
            Log.e(TAG,"",e);
        }

        return connectedDevices;
    }


Number 49:
API Relative Path:
src.android.bluetooth.BluetoothManager.java-getDevicesMatchingConnectionStates(int-int[])
Corresponding Source:
/**
     *
     * Get a list of devices that match any of the given connection
     * states.
     *
     * <p> If none of the devices match any of the given states,
     * an empty list will be returned.
     *
     * <p>This is not specific to any application configuration but represents
     * the connection state of the local Bluetooth adapter for this profile.
     * This can be used by applications like status bar which would just like
     * to know the state of the local adapter.
     *
     * <p>Requires {@link android.Manifest.permission#BLUETOOTH} permission.
     *
     * @param profile GATT or GATT_SERVER
     * @param states Array of states. States can be one of
     *        {@link BluetoothProfile#STATE_CONNECTED}, {@link BluetoothProfile#STATE_CONNECTING},
     *        {@link BluetoothProfile#STATE_DISCONNECTED},
     *        {@link BluetoothProfile#STATE_DISCONNECTING},
     * @return List of devices. The list will be empty on error.
     */
    @RequiresPermission(Manifest.permission.BLUETOOTH)
    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int profile, int[] states) {
        if (DBG) Log.d(TAG,"getDevicesMatchingConnectionStates");

        if (profile != BluetoothProfile.GATT && profile != BluetoothProfile.GATT_SERVER) {
            throw new IllegalArgumentException("Profile not supported: " + profile);
        }

        List<BluetoothDevice> devices = new ArrayList<BluetoothDevice>();

        try {
            IBluetoothManager managerService = mAdapter.getBluetoothManager();
            IBluetoothGatt iGatt = managerService.getBluetoothGatt();
            if (iGatt == null) return devices;
            devices = iGatt.getDevicesMatchingConnectionStates(states);
        } catch (RemoteException e) {
            Log.e(TAG,"",e);
        }

        return devices;
    }


Number 50:
API Relative Path:
src.android.bluetooth.BluetoothManager.java-openGattServer(Context-BluetoothGattServerCallback-int)
Corresponding Source:
/**
     * Open a GATT Server
     * The callback is used to deliver results to Caller, such as connection status as well
     * as the results of any other GATT server operations.
     * The method returns a BluetoothGattServer instance. You can use BluetoothGattServer
     * to conduct GATT server operations.
     * @param context App context
     * @param callback GATT server callback handler that will receive asynchronous callbacks.
     * @param transport preferred transport for GATT connections to remote dual-mode devices
     *             {@link BluetoothDevice#TRANSPORT_AUTO} or
     *             {@link BluetoothDevice#TRANSPORT_BREDR} or {@link BluetoothDevice#TRANSPORT_LE}
     * @return BluetoothGattServer instance
     * @hide
     */
    public BluetoothGattServer openGattServer(Context context,
                                              BluetoothGattServerCallback callback,int transport) {
        if (context == null || callback == null) {
            throw new IllegalArgumentException("null parameter: " + context + " " + callback);
        }

        // TODO(Bluetooth) check whether platform support BLE
        //     Do the check here or in GattServer?

        try {
            IBluetoothManager managerService = mAdapter.getBluetoothManager();
            IBluetoothGatt iGatt = managerService.getBluetoothGatt();
            if (iGatt == null) {
                Log.e(TAG, "Fail to get GATT Server connection");
                return null;
            }
            BluetoothGattServer mGattServer = new BluetoothGattServer(context, iGatt,transport);
            Boolean regStatus = mGattServer.registerCallback(callback);
            return regStatus? mGattServer : null;
        } catch (RemoteException e) {
            Log.e(TAG,"",e);
            return null;
        }
    }


Number 51:
API Relative Path:
src.android.bluetooth.BluetoothOutputStream.java-write(byte[]-int-int)
Corresponding Source:
/**
     * Writes {@code count} bytes from the byte array {@code buffer} starting
     * at position {@code offset} to this stream.
     *
     * @param b
     *            the buffer to be written.
     * @param offset
     *            the start position in {@code buffer} from where to get bytes.
     * @param count
     *            the number of bytes from {@code buffer} to write to this
     *            stream.
     * @throws IOException
     *             if an error occurs while writing to this stream.
     * @throws IndexOutOfBoundsException
     *             if {@code offset < 0} or {@code count < 0}, or if
     *             {@code offset + count} is bigger than the length of
     *             {@code buffer}.
     * @since Android 1.0
     */
    public void write(byte[] b, int offset, int count) throws IOException {
        if (b == null) {
            throw new NullPointerException("buffer is null");
        }
        if ((offset | count) < 0 || count > b.length - offset) {
            throw new IndexOutOfBoundsException("invalid offset or length");
        }
        mSocket.write(b, offset, count);
    }


Number 52:
API Relative Path:
src.android.bluetooth.BluetoothOutputStream.java-write(byte[]-int-int)
Corresponding Source:
/**
     * Writes {@code count} bytes from the byte array {@code buffer} starting
     * at position {@code offset} to this stream.
     *
     * @param b
     *            the buffer to be written.
     * @param offset
     *            the start position in {@code buffer} from where to get bytes.
     * @param count
     *            the number of bytes from {@code buffer} to write to this
     *            stream.
     * @throws IOException
     *             if an error occurs while writing to this stream.
     * @throws IndexOutOfBoundsException
     *             if {@code offset < 0} or {@code count < 0}, or if
     *             {@code offset + count} is bigger than the length of
     *             {@code buffer}.
     * @since Android 1.0
     */
    public void write(byte[] b, int offset, int count) throws IOException {
        if (b == null) {
            throw new NullPointerException("buffer is null");
        }
        if ((offset | count) < 0 || count > b.length - offset) {
            throw new IndexOutOfBoundsException("invalid offset or length");
        }
        mSocket.write(b, offset, count);
    }


Number 53:
API Relative Path:
src.android.bluetooth.BluetoothSocket.java-BluetoothSocket(int-int-boolean-boolean-BluetoothDevice-int-ParcelUuid-boolean-boolean)
Corresponding Source:
/**
     * Construct a BluetoothSocket.
     * @param type    type of socket
     * @param fd      fd to use for connected socket, or -1 for a new socket
     * @param auth    require the remote device to be authenticated
     * @param encrypt require the connection to be encrypted
     * @param device  remote device that this socket can connect to
     * @param port    remote port
     * @param uuid    SDP uuid
     * @param mitm    enforce man-in-the-middle protection.
     * @param min16DigitPin enforce a minimum length of 16 digits for a sec mode 2 connection
     * @throws IOException On error, for example Bluetooth not available, or
     *                     insufficient privileges
     */
    /*package*/ BluetoothSocket(int type, int fd, boolean auth, boolean encrypt,
            BluetoothDevice device, int port, ParcelUuid uuid, boolean mitm, boolean min16DigitPin)
                    throws IOException {
        if (VDBG) Log.d(TAG, "Creating new BluetoothSocket of type: " + type);
        if (type == BluetoothSocket.TYPE_RFCOMM && uuid == null && fd == -1
                && port != BluetoothAdapter.SOCKET_CHANNEL_AUTO_STATIC_NO_SDP) {
            if (port < 1 || port > MAX_RFCOMM_CHANNEL) {
                throw new IOException("Invalid RFCOMM channel: " + port);
            }
        }
        if (uuid != null)
            mUuid = uuid;
        else mUuid = new ParcelUuid(new UUID(0, 0));
        mType = type;
        mAuth = auth;
        mAuthMitm = mitm;
        mMin16DigitPin = min16DigitPin;
        mEncrypt = encrypt;
        mDevice = device;
        mPort = port;
        mFd = fd;

        mSocketState = SocketState.INIT;

        if (device == null) {
            // Server socket
            mAddress = BluetoothAdapter.getDefaultAdapter().getAddress();
        } else {
            // Remote socket
            mAddress = device.getAddress();
        }
        mInputStream = new BluetoothInputStream(this);
        mOutputStream = new BluetoothOutputStream(this);
    }


Number 54:
API Relative Path:
src.android.bluetooth.BluetoothUuid.java-parseUuidFrom(byte[])
Corresponding Source:
/**
     * Parse UUID from bytes. The {@code uuidBytes} can represent a 16-bit, 32-bit or 128-bit UUID,
     * but the returned UUID is always in 128-bit format.
     * Note UUID is little endian in Bluetooth.
     *
     * @param uuidBytes Byte representation of uuid.
     * @return {@link ParcelUuid} parsed from bytes.
     * @throws IllegalArgumentException If the {@code uuidBytes} cannot be parsed.
     */
    public static ParcelUuid parseUuidFrom(byte[] uuidBytes) {
        if (uuidBytes == null) {
            throw new IllegalArgumentException("uuidBytes cannot be null");
        }
        int length = uuidBytes.length;
        if (length != UUID_BYTES_16_BIT && length != UUID_BYTES_32_BIT &&
                length != UUID_BYTES_128_BIT) {
            throw new IllegalArgumentException("uuidBytes length invalid - " + length);
        }

        // Construct a 128 bit UUID.
        if (length == UUID_BYTES_128_BIT) {
            ByteBuffer buf = ByteBuffer.wrap(uuidBytes).order(ByteOrder.LITTLE_ENDIAN);
            long msb = buf.getLong(8);
            long lsb = buf.getLong(0);
            return new ParcelUuid(new UUID(msb, lsb));
        }

        // For 16 bit and 32 bit UUID we need to convert them to 128 bit value.
        // 128_bit_value = uuid * 2^96 + BASE_UUID
        long shortUuid;
        if (length == UUID_BYTES_16_BIT) {
            shortUuid = uuidBytes[0] & 0xFF;
            shortUuid += (uuidBytes[1] & 0xFF) << 8;
        } else {
            shortUuid = uuidBytes[0] & 0xFF ;
            shortUuid += (uuidBytes[1] & 0xFF) << 8;
            shortUuid += (uuidBytes[2] & 0xFF) << 16;
            shortUuid += (uuidBytes[3] & 0xFF) << 24;
        }
        long msb = BASE_UUID.getUuid().getMostSignificantBits() + (shortUuid << 32);
        long lsb = BASE_UUID.getUuid().getLeastSignificantBits();
        return new ParcelUuid(new UUID(msb, lsb));
    }


Number 55:
API Relative Path:
src.android.bluetooth.le.BluetoothLeAdvertiser.java-startAdvertising(AdvertiseSettings-AdvertiseData-AdvertiseData-AdvertiseCallback)
Corresponding Source:
/**
     * Start Bluetooth LE Advertising. The {@code advertiseData} will be broadcasted if the
     * operation succeeds. The {@code scanResponse} is returned when a scanning device sends an
     * active scan request. This method returns immediately, the operation status is delivered
     * through {@code callback}.
     * <p>
     * Requires {@link android.Manifest.permission#BLUETOOTH_ADMIN}
     *
     * @param settings Settings for Bluetooth LE advertising.
     * @param advertiseData Advertisement data to be advertised in advertisement packet.
     * @param scanResponse Scan response associated with the advertisement data.
     * @param callback Callback for advertising status.
     */
    public void startAdvertising(AdvertiseSettings settings,
            AdvertiseData advertiseData, AdvertiseData scanResponse,
            final AdvertiseCallback callback) {
        synchronized (mLeAdvertisers) {
            BluetoothLeUtils.checkAdapterStateOn(mBluetoothAdapter);
            if (callback == null) {
                throw new IllegalArgumentException("callback cannot be null");
            }
            if (!mBluetoothAdapter.isMultipleAdvertisementSupported() &&
                    !mBluetoothAdapter.isPeripheralModeSupported()) {
                postStartFailure(callback,
                        AdvertiseCallback.ADVERTISE_FAILED_FEATURE_UNSUPPORTED);
                return;
            }
            boolean isConnectable = settings.isConnectable();
            if (totalBytes(advertiseData, isConnectable) > MAX_ADVERTISING_DATA_BYTES ||
                    totalBytes(scanResponse, false) > MAX_ADVERTISING_DATA_BYTES) {
                postStartFailure(callback, AdvertiseCallback.ADVERTISE_FAILED_DATA_TOO_LARGE);
                return;
            }
            if (mLeAdvertisers.containsKey(callback)) {
                postStartFailure(callback, AdvertiseCallback.ADVERTISE_FAILED_ALREADY_STARTED);
                return;
            }

            IBluetoothGatt gatt;
            try {
                gatt = mBluetoothManager.getBluetoothGatt();
            } catch (RemoteException e) {
                Log.e(TAG, "Failed to get Bluetooth gatt - ", e);
                postStartFailure(callback, AdvertiseCallback.ADVERTISE_FAILED_INTERNAL_ERROR);
                return;
            }
            AdvertiseCallbackWrapper wrapper = new AdvertiseCallbackWrapper(callback, advertiseData,
                    scanResponse, settings, gatt);
            wrapper.startRegisteration();
        }
    }


Number 56:
API Relative Path:
src.android.bluetooth.le.BluetoothLeAdvertiser.java-stopAdvertising(AdvertiseCallback)
Corresponding Source:
/**
     * Stop Bluetooth LE advertising. The {@code callback} must be the same one use in
     * {@link BluetoothLeAdvertiser#startAdvertising}.
     * <p>
     * Requires {@link android.Manifest.permission#BLUETOOTH_ADMIN} permission.
     *
     * @param callback {@link AdvertiseCallback} identifies the advertising instance to stop.
     */
    public void stopAdvertising(final AdvertiseCallback callback) {
        synchronized (mLeAdvertisers) {
            if (callback == null) {
                throw new IllegalArgumentException("callback cannot be null");
            }
            AdvertiseCallbackWrapper wrapper = mLeAdvertisers.get(callback);
            if (wrapper == null) return;
            wrapper.stopAdvertising();
        }
    }


Number 57:
API Relative Path:
src.android.bluetooth.le.BluetoothLeScanner.java-flushPendingScanResults(ScanCallback)
Corresponding Source:
/**
     * Flush pending batch scan results stored in Bluetooth controller. This will return Bluetooth
     * LE scan results batched on bluetooth controller. Returns immediately, batch scan results data
     * will be delivered through the {@code callback}.
     *
     * @param callback Callback of the Bluetooth LE Scan, it has to be the same instance as the one
     *            used to start scan.
     */
    public void flushPendingScanResults(ScanCallback callback) {
        BluetoothLeUtils.checkAdapterStateOn(mBluetoothAdapter);
        if (callback == null) {
            throw new IllegalArgumentException("callback cannot be null!");
        }
        synchronized (mLeScanClients) {
            BleScanCallbackWrapper wrapper = mLeScanClients.get(callback);
            if (wrapper == null) {
                return;
            }
            wrapper.flushPendingBatchResults();
        }
    }


Number 58:
API Relative Path:
src.android.bluetooth.le.BluetoothLeUtils.java-checkAdapterStateOn(BluetoothAdapter)
Corresponding Source:
/**
     * Ensure Bluetooth is turned on.
     *
     * @throws IllegalStateException If {@code adapter} is null or Bluetooth state is not
     *             {@link BluetoothAdapter#STATE_ON}.
     */
    static void checkAdapterStateOn(BluetoothAdapter adapter) {
        if (adapter == null || !adapter.isLeEnabled()) {//adapter.getState() != BluetoothAdapter.STATE_ON) {
            throw new IllegalStateException("BT Adapter is not turned ON");
        }
    }


Number 59:
API Relative Path:
src.android.bluetooth.le.ScanRecord.java-getServiceData(ParcelUuid)
Corresponding Source:
/**
     * Returns the service data byte array associated with the {@code serviceUuid}. Returns
     * {@code null} if the {@code serviceDataUuid} is not found.
     */
    @Nullable
    public byte[] getServiceData(ParcelUuid serviceDataUuid) {
        if (serviceDataUuid == null) {
            return null;
        }
        return mServiceData.get(serviceDataUuid);
    }


Number 60:
API Relative Path:
src.android.bluetooth.le.ScanRecord.java-parseFromBytes(byte[])
Corresponding Source:
/**
     * Parse scan record bytes to {@link ScanRecord}.
     * <p>
     * The format is defined in Bluetooth 4.1 specification, Volume 3, Part C, Section 11 and 18.
     * <p>
     * All numerical multi-byte entities and values shall use little-endian <strong>byte</strong>
     * order.
     *
     * @param scanRecord The scan record of Bluetooth LE advertisement and/or scan response.
     * @hide
     */
    public static ScanRecord parseFromBytes(byte[] scanRecord) {
        if (scanRecord == null) {
            return null;
        }

        int currentPos = 0;
        int advertiseFlag = -1;
        List<ParcelUuid> serviceUuids = new ArrayList<ParcelUuid>();
        String localName = null;
        int txPowerLevel = Integer.MIN_VALUE;

        SparseArray<byte[]> manufacturerData = new SparseArray<byte[]>();
        Map<ParcelUuid, byte[]> serviceData = new ArrayMap<ParcelUuid, byte[]>();

        try {
            while (currentPos < scanRecord.length) {
                // length is unsigned int.
                int length = scanRecord[currentPos++] & 0xFF;
                if (length == 0) {
                    break;
                }
                // Note the length includes the length of the field type itself.
                int dataLength = length - 1;
                // fieldType is unsigned int.
                int fieldType = scanRecord[currentPos++] & 0xFF;
                switch (fieldType) {
                    case DATA_TYPE_FLAGS:
                        advertiseFlag = scanRecord[currentPos] & 0xFF;
                        break;
                    case DATA_TYPE_SERVICE_UUIDS_16_BIT_PARTIAL:
                    case DATA_TYPE_SERVICE_UUIDS_16_BIT_COMPLETE:
                        parseServiceUuid(scanRecord, currentPos,
                                dataLength, BluetoothUuid.UUID_BYTES_16_BIT, serviceUuids);
                        break;
                    case DATA_TYPE_SERVICE_UUIDS_32_BIT_PARTIAL:
                    case DATA_TYPE_SERVICE_UUIDS_32_BIT_COMPLETE:
                        parseServiceUuid(scanRecord, currentPos, dataLength,
                                BluetoothUuid.UUID_BYTES_32_BIT, serviceUuids);
                        break;
                    case DATA_TYPE_SERVICE_UUIDS_128_BIT_PARTIAL:
                    case DATA_TYPE_SERVICE_UUIDS_128_BIT_COMPLETE:
                        parseServiceUuid(scanRecord, currentPos, dataLength,
                                BluetoothUuid.UUID_BYTES_128_BIT, serviceUuids);
                        break;
                    case DATA_TYPE_LOCAL_NAME_SHORT:
                    case DATA_TYPE_LOCAL_NAME_COMPLETE:
                        localName = new String(
                                extractBytes(scanRecord, currentPos, dataLength));
                        break;
                    case DATA_TYPE_TX_POWER_LEVEL:
                        txPowerLevel = scanRecord[currentPos];
                        break;
                    case DATA_TYPE_SERVICE_DATA:
                        // The first two bytes of the service data are service data UUID in little
                        // endian. The rest bytes are service data.
                        int serviceUuidLength = BluetoothUuid.UUID_BYTES_16_BIT;
                        byte[] serviceDataUuidBytes = extractBytes(scanRecord, currentPos,
                                serviceUuidLength);
                        ParcelUuid serviceDataUuid = BluetoothUuid.parseUuidFrom(
                                serviceDataUuidBytes);
                        byte[] serviceDataArray = extractBytes(scanRecord,
                                currentPos + serviceUuidLength, dataLength - serviceUuidLength);
                        serviceData.put(serviceDataUuid, serviceDataArray);
                        break;
                    case DATA_TYPE_MANUFACTURER_SPECIFIC_DATA:
                        // The first two bytes of the manufacturer specific data are
                        // manufacturer ids in little endian.
                        int manufacturerId = ((scanRecord[currentPos + 1] & 0xFF) << 8) +
                                (scanRecord[currentPos] & 0xFF);
                        byte[] manufacturerDataBytes = extractBytes(scanRecord, currentPos + 2,
                                dataLength - 2);
                        manufacturerData.put(manufacturerId, manufacturerDataBytes);
                        break;
                    default:
                        // Just ignore, we don't handle such data type.
                        break;
                }
                currentPos += dataLength;
            }

            if (serviceUuids.isEmpty()) {
                serviceUuids = null;
            }
            return new ScanRecord(serviceUuids, manufacturerData, serviceData,
                    advertiseFlag, txPowerLevel, localName, scanRecord);
        } catch (Exception e) {
            Log.e(TAG, "unable to parse scan record: " + Arrays.toString(scanRecord));
            // As the record is invalid, ignore all the parsed results for this packet
            // and return an empty record with raw scanRecord bytes in results
            return new ScanRecord(null, null, null, -1, Integer.MIN_VALUE, null, scanRecord);
        }
    }


Number 61:
API Relative Path:
src.android.database.BulkCursorNative.java-asInterface(IBinder)
Corresponding Source:
/**
     * Cast a Binder object into a content resolver interface, generating
     * a proxy if needed.
     */
    static public IBulkCursor asInterface(IBinder obj)
    {
        if (obj == null) {
            return null;
        }
        IBulkCursor in = (IBulkCursor)obj.queryLocalInterface(descriptor);
        if (in != null) {
            return in;
        }

        return new BulkCursorProxy(obj);
    }


Number 62:
API Relative Path:
src.android.database.CursorJoiner.java-CursorJoiner(Cursor-String[]-Cursor-String[])
Corresponding Source:
/**
     * Initializes the CursorJoiner and resets the cursors to the first row. The left and right
     * column name arrays must have the same number of columns.
     * @param cursorLeft The left cursor to compare
     * @param columnNamesLeft The column names to compare from the left cursor
     * @param cursorRight The right cursor to compare
     * @param columnNamesRight The column names to compare from the right cursor
     */
    public CursorJoiner(
            Cursor cursorLeft, String[] columnNamesLeft,
            Cursor cursorRight, String[] columnNamesRight) {
        if (columnNamesLeft.length != columnNamesRight.length) {
            throw new IllegalArgumentException(
                    "you must have the same number of columns on the left and right, "
                            + columnNamesLeft.length + " != " + columnNamesRight.length);
        }

        mCursorLeft = cursorLeft;
        mCursorRight = cursorRight;

        mCursorLeft.moveToFirst();
        mCursorRight.moveToFirst();

        mCompareResultIsValid = false;

        mColumnsLeft = buildColumnIndiciesArray(cursorLeft, columnNamesLeft);
        mColumnsRight = buildColumnIndiciesArray(cursorRight, columnNamesRight);

        mValues = new String[mColumnsLeft.length * 2];
    }


Number 63:
API Relative Path:
src.android.database.CursorWindow.java-copyStringToBuffer(int-int-CharArrayBuffer)
Corresponding Source:
/**
     * Copies the text of the field at the specified row and column index into
     * a {@link CharArrayBuffer}.
     * <p>
     * The buffer is populated as follows:
     * <ul>
     * <li>If the buffer is too small for the value to be copied, then it is
     * automatically resized.</li>
     * <li>If the field is of type {@link Cursor#FIELD_TYPE_NULL}, then the buffer
     * is set to an empty string.</li>
     * <li>If the field is of type {@link Cursor#FIELD_TYPE_STRING}, then the buffer
     * is set to the contents of the string.</li>
     * <li>If the field is of type {@link Cursor#FIELD_TYPE_INTEGER}, then the buffer
     * is set to a string representation of the integer in decimal, obtained by formatting the
     * value with the <code>printf</code> family of functions using
     * format specifier <code>%lld</code>.</li>
     * <li>If the field is of type {@link Cursor#FIELD_TYPE_FLOAT}, then the buffer is
     * set to a string representation of the floating-point value in decimal, obtained by
     * formatting the value with the <code>printf</code> family of functions using
     * format specifier <code>%g</code>.</li>
     * <li>If the field is of type {@link Cursor#FIELD_TYPE_BLOB}, then a
     * {@link SQLiteException} is thrown.</li>
     * </ul>
     * </p>
     *
     * @param row The zero-based row index.
     * @param column The zero-based column index.
     * @param buffer The {@link CharArrayBuffer} to hold the string.  It is automatically
     * resized if the requested string is larger than the buffer's current capacity.
      */
    public void copyStringToBuffer(int row, int column, CharArrayBuffer buffer) {
        if (buffer == null) {
            throw new IllegalArgumentException("CharArrayBuffer should not be null");
        }
        acquireReference();
        try {
            nativeCopyStringToBuffer(mWindowPtr, row - mStartPos, column, buffer);
        } finally {
            releaseReference();
        }
    }


Number 64:
API Relative Path:
src.android.database.MatrixCursor.java-addRow(Object[])
Corresponding Source:
/**
     * Adds a new row to the end with the given column values. Not safe
     * for concurrent use.
     *
     * @throws IllegalArgumentException if {@code columnValues.length !=
     *  columnNames.length}
     * @param columnValues in the same order as the the column names specified
     *  at cursor construction time
     */
    public void addRow(Object[] columnValues) {
        if (columnValues.length != columnCount) {
            throw new IllegalArgumentException("columnNames.length = "
                    + columnCount + ", columnValues.length = "
                    + columnValues.length);
        }

        int start = rowCount++ * columnCount;
        ensureCapacity(start + columnCount);
        System.arraycopy(columnValues, 0, data, start, columnCount);
    }


Number 65:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-execute(String-Object[]-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that does not return a result.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public void execute(String sql, Object[] bindArgs,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        final int cookie = mRecentOperations.beginOperation("execute", sql, bindArgs);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                throwIfStatementForbidden(statement);
                bindArguments(statement, bindArgs);
                applyBlockGuardPolicy(statement);
                attachCancellationSignal(cancellationSignal);
                try {
                    nativeExecute(mConnectionPtr, statement.mStatementPtr);
                } finally {
                    detachCancellationSignal(cancellationSignal);
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            mRecentOperations.endOperation(cookie);
        }
    }


Number 66:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForBlobFileDescriptor(String-Object[]-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a single BLOB result as a
     * file descriptor to a shared memory region.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The file descriptor for a shared memory region that contains
     * the value of the first column in the first row of the result set as a BLOB,
     * or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public ParcelFileDescriptor executeForBlobFileDescriptor(String sql, Object[] bindArgs,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        final int cookie = mRecentOperations.beginOperation("executeForBlobFileDescriptor",
                sql, bindArgs);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                throwIfStatementForbidden(statement);
                bindArguments(statement, bindArgs);
                applyBlockGuardPolicy(statement);
                attachCancellationSignal(cancellationSignal);
                try {
                    int fd = nativeExecuteForBlobFileDescriptor(
                            mConnectionPtr, statement.mStatementPtr);
                    return fd >= 0 ? ParcelFileDescriptor.adoptFd(fd) : null;
                } finally {
                    detachCancellationSignal(cancellationSignal);
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            mRecentOperations.endOperation(cookie);
        }
    }


Number 67:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForChangedRowCount(String-Object[]-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a count of the number of rows
     * that were changed.  Use for UPDATE or DELETE SQL statements.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The number of rows that were changed.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public int executeForChangedRowCount(String sql, Object[] bindArgs,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        int changedRows = 0;
        final int cookie = mRecentOperations.beginOperation("executeForChangedRowCount",
                sql, bindArgs);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                throwIfStatementForbidden(statement);
                bindArguments(statement, bindArgs);
                applyBlockGuardPolicy(statement);
                attachCancellationSignal(cancellationSignal);
                try {
                    changedRows = nativeExecuteForChangedRowCount(
                            mConnectionPtr, statement.mStatementPtr);
                    return changedRows;
                } finally {
                    detachCancellationSignal(cancellationSignal);
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            if (mRecentOperations.endOperationDeferLog(cookie)) {
                mRecentOperations.logOperation(cookie, "changedRows=" + changedRows);
            }
        }
    }


Number 68:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForCursorWindow(String-Object[]-CursorWindow-int-int-boolean-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement and populates the specified {@link CursorWindow}
     * with a range of results.  Returns the number of rows that were counted
     * during query execution.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param window The cursor window to clear and fill.
     * @param startPos The start position for filling the window.
     * @param requiredPos The position of a row that MUST be in the window.
     * If it won't fit, then the query should discard part of what it filled
     * so that it does.  Must be greater than or equal to <code>startPos</code>.
     * @param countAllRows True to count all rows that the query would return
     * regagless of whether they fit in the window.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The number of rows that were counted during query execution.  Might
     * not be all rows in the result set unless <code>countAllRows</code> is true.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public int executeForCursorWindow(String sql, Object[] bindArgs,
            CursorWindow window, int startPos, int requiredPos, boolean countAllRows,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }
        if (window == null) {
            throw new IllegalArgumentException("window must not be null.");
        }

        window.acquireReference();
        try {
            int actualPos = -1;
            int countedRows = -1;
            int filledRows = -1;
            final int cookie = mRecentOperations.beginOperation("executeForCursorWindow",
                    sql, bindArgs);
            try {
                final PreparedStatement statement = acquirePreparedStatement(sql);
                try {
                    throwIfStatementForbidden(statement);
                    bindArguments(statement, bindArgs);
                    applyBlockGuardPolicy(statement);
                    attachCancellationSignal(cancellationSignal);
                    try {
                        final long result = nativeExecuteForCursorWindow(
                                mConnectionPtr, statement.mStatementPtr, window.mWindowPtr,
                                startPos, requiredPos, countAllRows);
                        actualPos = (int)(result >> 32);
                        countedRows = (int)result;
                        filledRows = window.getNumRows();
                        window.setStartPosition(actualPos);
                        return countedRows;
                    } finally {
                        detachCancellationSignal(cancellationSignal);
                    }
                } finally {
                    releasePreparedStatement(statement);
                }
            } catch (RuntimeException ex) {
                mRecentOperations.failOperation(cookie, ex);
                throw ex;
            } finally {
                if (mRecentOperations.endOperationDeferLog(cookie)) {
                    mRecentOperations.logOperation(cookie, "window='" + window
                            + "', startPos=" + startPos
                            + ", actualPos=" + actualPos
                            + ", filledRows=" + filledRows
                            + ", countedRows=" + countedRows);
                }
            }
        } finally {
            window.releaseReference();
        }
    }


Number 69:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForCursorWindow(String-Object[]-CursorWindow-int-int-boolean-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement and populates the specified {@link CursorWindow}
     * with a range of results.  Returns the number of rows that were counted
     * during query execution.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param window The cursor window to clear and fill.
     * @param startPos The start position for filling the window.
     * @param requiredPos The position of a row that MUST be in the window.
     * If it won't fit, then the query should discard part of what it filled
     * so that it does.  Must be greater than or equal to <code>startPos</code>.
     * @param countAllRows True to count all rows that the query would return
     * regagless of whether they fit in the window.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The number of rows that were counted during query execution.  Might
     * not be all rows in the result set unless <code>countAllRows</code> is true.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public int executeForCursorWindow(String sql, Object[] bindArgs,
            CursorWindow window, int startPos, int requiredPos, boolean countAllRows,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }
        if (window == null) {
            throw new IllegalArgumentException("window must not be null.");
        }

        window.acquireReference();
        try {
            int actualPos = -1;
            int countedRows = -1;
            int filledRows = -1;
            final int cookie = mRecentOperations.beginOperation("executeForCursorWindow",
                    sql, bindArgs);
            try {
                final PreparedStatement statement = acquirePreparedStatement(sql);
                try {
                    throwIfStatementForbidden(statement);
                    bindArguments(statement, bindArgs);
                    applyBlockGuardPolicy(statement);
                    attachCancellationSignal(cancellationSignal);
                    try {
                        final long result = nativeExecuteForCursorWindow(
                                mConnectionPtr, statement.mStatementPtr, window.mWindowPtr,
                                startPos, requiredPos, countAllRows);
                        actualPos = (int)(result >> 32);
                        countedRows = (int)result;
                        filledRows = window.getNumRows();
                        window.setStartPosition(actualPos);
                        return countedRows;
                    } finally {
                        detachCancellationSignal(cancellationSignal);
                    }
                } finally {
                    releasePreparedStatement(statement);
                }
            } catch (RuntimeException ex) {
                mRecentOperations.failOperation(cookie, ex);
                throw ex;
            } finally {
                if (mRecentOperations.endOperationDeferLog(cookie)) {
                    mRecentOperations.logOperation(cookie, "window='" + window
                            + "', startPos=" + startPos
                            + ", actualPos=" + actualPos
                            + ", filledRows=" + filledRows
                            + ", countedRows=" + countedRows);
                }
            }
        } finally {
            window.releaseReference();
        }
    }


Number 70:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForLastInsertedRowId(String-Object[]-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns the row id of the last row inserted
     * by the statement.  Use for INSERT SQL statements.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The row id of the last row that was inserted, or 0 if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public long executeForLastInsertedRowId(String sql, Object[] bindArgs,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        final int cookie = mRecentOperations.beginOperation("executeForLastInsertedRowId",
                sql, bindArgs);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                throwIfStatementForbidden(statement);
                bindArguments(statement, bindArgs);
                applyBlockGuardPolicy(statement);
                attachCancellationSignal(cancellationSignal);
                try {
                    return nativeExecuteForLastInsertedRowId(
                            mConnectionPtr, statement.mStatementPtr);
                } finally {
                    detachCancellationSignal(cancellationSignal);
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            mRecentOperations.endOperation(cookie);
        }
    }


Number 71:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForLong(String-Object[]-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a single <code>long</code> result.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The value of the first column in the first row of the result set
     * as a <code>long</code>, or zero if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public long executeForLong(String sql, Object[] bindArgs,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        final int cookie = mRecentOperations.beginOperation("executeForLong", sql, bindArgs);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                throwIfStatementForbidden(statement);
                bindArguments(statement, bindArgs);
                applyBlockGuardPolicy(statement);
                attachCancellationSignal(cancellationSignal);
                try {
                    return nativeExecuteForLong(mConnectionPtr, statement.mStatementPtr);
                } finally {
                    detachCancellationSignal(cancellationSignal);
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            mRecentOperations.endOperation(cookie);
        }
    }


Number 72:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-executeForString(String-Object[]-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a single {@link String} result.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The value of the first column in the first row of the result set
     * as a <code>String</code>, or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public String executeForString(String sql, Object[] bindArgs,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        final int cookie = mRecentOperations.beginOperation("executeForString", sql, bindArgs);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                throwIfStatementForbidden(statement);
                bindArguments(statement, bindArgs);
                applyBlockGuardPolicy(statement);
                attachCancellationSignal(cancellationSignal);
                try {
                    return nativeExecuteForString(mConnectionPtr, statement.mStatementPtr);
                } finally {
                    detachCancellationSignal(cancellationSignal);
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            mRecentOperations.endOperation(cookie);
        }
    }


Number 73:
API Relative Path:
src.android.database.sqlite.SQLiteConnection.java-prepare(String-SQLiteStatementInfo)
Corresponding Source:
/**
     * Prepares a statement for execution but does not bind its parameters or execute it.
     * <p>
     * This method can be used to check for syntax errors during compilation
     * prior to execution of the statement.  If the {@code outStatementInfo} argument
     * is not null, the provided {@link SQLiteStatementInfo} object is populated
     * with information about the statement.
     * </p><p>
     * A prepared statement makes no reference to the arguments that may eventually
     * be bound to it, consequently it it possible to cache certain prepared statements
     * such as SELECT or INSERT/UPDATE statements.  If the statement is cacheable,
     * then it will be stored in the cache for later.
     * </p><p>
     * To take advantage of this behavior as an optimization, the connection pool
     * provides a method to acquire a connection that already has a given SQL statement
     * in its prepared statement cache so that it is ready for execution.
     * </p>
     *
     * @param sql The SQL statement to prepare.
     * @param outStatementInfo The {@link SQLiteStatementInfo} object to populate
     * with information about the statement, or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error.
     */
    public void prepare(String sql, SQLiteStatementInfo outStatementInfo) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        final int cookie = mRecentOperations.beginOperation("prepare", sql, null);
        try {
            final PreparedStatement statement = acquirePreparedStatement(sql);
            try {
                if (outStatementInfo != null) {
                    outStatementInfo.numParameters = statement.mNumParameters;
                    outStatementInfo.readOnly = statement.mReadOnly;

                    final int columnCount = nativeGetColumnCount(
                            mConnectionPtr, statement.mStatementPtr);
                    if (columnCount == 0) {
                        outStatementInfo.columnNames = EMPTY_STRING_ARRAY;
                    } else {
                        outStatementInfo.columnNames = new String[columnCount];
                        for (int i = 0; i < columnCount; i++) {
                            outStatementInfo.columnNames[i] = nativeGetColumnName(
                                    mConnectionPtr, statement.mStatementPtr, i);
                        }
                    }
                }
            } finally {
                releasePreparedStatement(statement);
            }
        } catch (RuntimeException ex) {
            mRecentOperations.failOperation(cookie, ex);
            throw ex;
        } finally {
            mRecentOperations.endOperation(cookie);
        }
    }


Number 74:
API Relative Path:
src.android.database.sqlite.SQLiteConnectionPool.java-open(SQLiteDatabaseConfiguration)
Corresponding Source:
/**
     * Opens a connection pool for the specified database.
     *
     * @param configuration The database configuration.
     * @return The connection pool.
     *
     * @throws SQLiteException if a database error occurs.
     */
    public static SQLiteConnectionPool open(SQLiteDatabaseConfiguration configuration) {
        if (configuration == null) {
            throw new IllegalArgumentException("configuration must not be null.");
        }

        // Create the pool.
        SQLiteConnectionPool pool = new SQLiteConnectionPool(configuration);
        pool.open(); // might throw
        return pool;
    }


Number 75:
API Relative Path:
src.android.database.sqlite.SQLiteConnectionPool.java-reconfigure(SQLiteDatabaseConfiguration)
Corresponding Source:
/**
     * Reconfigures the database configuration of the connection pool and all of its
     * connections.
     * <p>
     * Configuration changes are propagated down to connections immediately if
     * they are available or as soon as they are released.  This includes changes
     * that affect the size of the pool.
     * </p>
     *
     * @param configuration The new configuration.
     *
     * @throws IllegalStateException if the pool has been closed.
     */
    public void reconfigure(SQLiteDatabaseConfiguration configuration) {
        if (configuration == null) {
            throw new IllegalArgumentException("configuration must not be null.");
        }

        synchronized (mLock) {
            throwIfClosedLocked();

            boolean walModeChanged = ((configuration.openFlags ^ mConfiguration.openFlags)
                    & SQLiteDatabase.ENABLE_WRITE_AHEAD_LOGGING) != 0;
            if (walModeChanged) {
                // WAL mode can only be changed if there are no acquired connections
                // because we need to close all but the primary connection first.
                if (!mAcquiredConnections.isEmpty()) {
                    throw new IllegalStateException("Write Ahead Logging (WAL) mode cannot "
                            + "be enabled or disabled while there are transactions in "
                            + "progress.  Finish all transactions and release all active "
                            + "database connections first.");
                }

                // Close all non-primary connections.  This should happen immediately
                // because none of them are in use.
                closeAvailableNonPrimaryConnectionsAndLogExceptionsLocked();
                assert mAvailableNonPrimaryConnections.isEmpty();
            }

            boolean foreignKeyModeChanged = configuration.foreignKeyConstraintsEnabled
                    != mConfiguration.foreignKeyConstraintsEnabled;
            if (foreignKeyModeChanged) {
                // Foreign key constraints can only be changed if there are no transactions
                // in progress.  To make this clear, we throw an exception if there are
                // any acquired connections.
                if (!mAcquiredConnections.isEmpty()) {
                    throw new IllegalStateException("Foreign Key Constraints cannot "
                            + "be enabled or disabled while there are transactions in "
                            + "progress.  Finish all transactions and release all active "
                            + "database connections first.");
                }
            }

            if (mConfiguration.openFlags != configuration.openFlags) {
                // If we are changing open flags and WAL mode at the same time, then
                // we have no choice but to close the primary connection beforehand
                // because there can only be one connection open when we change WAL mode.
                if (walModeChanged) {
                    closeAvailableConnectionsAndLogExceptionsLocked();
                }

                // Try to reopen the primary connection using the new open flags then
                // close and discard all existing connections.
                // This might throw if the database is corrupt or cannot be opened in
                // the new mode in which case existing connections will remain untouched.
                SQLiteConnection newPrimaryConnection = openConnectionLocked(configuration,
                        true /*primaryConnection*/); // might throw

                closeAvailableConnectionsAndLogExceptionsLocked();
                discardAcquiredConnectionsLocked();

                mAvailablePrimaryConnection = newPrimaryConnection;
                mConfiguration.updateParametersFrom(configuration);
                setMaxConnectionPoolSizeLocked();
            } else {
                // Reconfigure the database connections in place.
                mConfiguration.updateParametersFrom(configuration);
                setMaxConnectionPoolSizeLocked();

                closeExcessConnectionsAndLogExceptionsLocked();
                reconfigureAllConnectionsLocked();
            }

            wakeConnectionWaitersLocked();
        }
    }


Number 76:
API Relative Path:
src.android.database.sqlite.SQLiteCursor.java-SQLiteCursor(SQLiteCursorDriver-String-SQLiteQuery)
Corresponding Source:
/**
     * Execute a query and provide access to its result set through a Cursor
     * interface. For a query such as: {@code SELECT name, birth, phone FROM
     * myTable WHERE ... LIMIT 1,20 ORDER BY...} the column names (name, birth,
     * phone) would be in the projection argument and everything from
     * {@code FROM} onward would be in the params argument.
     *
     * @param editTable the name of the table used for this query
     * @param query the {@link SQLiteQuery} object associated with this cursor object.
     */
    public SQLiteCursor(SQLiteCursorDriver driver, String editTable, SQLiteQuery query) {
        if (query == null) {
            throw new IllegalArgumentException("query object cannot be null");
        }
        if (StrictMode.vmSqliteObjectLeaksEnabled()) {
            mStackTrace = new DatabaseObjectNotClosedException().fillInStackTrace();
        } else {
            mStackTrace = null;
        }
        mDriver = driver;
        mEditTable = editTable;
        mColumnNameMap = null;
        mQuery = query;

        mColumns = query.getColumnNames();
    }


Number 77:
API Relative Path:
src.android.database.sqlite.SQLiteDatabase.java-deleteDatabase(File)
Corresponding Source:
/**
     * Deletes a database including its journal file and other auxiliary files
     * that may have been created by the database engine.
     *
     * @param file The database file path.
     * @return True if the database was successfully deleted.
     */
    public static boolean deleteDatabase(File file) {
        if (file == null) {
            throw new IllegalArgumentException("file must not be null");
        }

        boolean deleted = false;
        deleted |= file.delete();
        deleted |= new File(file.getPath() + "-journal").delete();
        deleted |= new File(file.getPath() + "-shm").delete();
        deleted |= new File(file.getPath() + "-wal").delete();

        File dir = file.getParentFile();
        if (dir != null) {
            final String prefix = file.getName() + "-mj";
            File[] files = dir.listFiles(new FileFilter() {
                @Override
                public boolean accept(File candidate) {
                    return candidate.getName().startsWith(prefix);
                }
            });
            if (files != null) {
                for (File masterJournal : files) {
                    deleted |= masterJournal.delete();
                }
            }
        }
        return deleted;
    }


Number 78:
API Relative Path:
src.android.database.sqlite.SQLiteDatabase.java-execSQL(String-Object[])
Corresponding Source:
/**
     * Execute a single SQL statement that is NOT a SELECT/INSERT/UPDATE/DELETE.
     * <p>
     * For INSERT statements, use any of the following instead.
     * <ul>
     *   <li>{@link #insert(String, String, ContentValues)}</li>
     *   <li>{@link #insertOrThrow(String, String, ContentValues)}</li>
     *   <li>{@link #insertWithOnConflict(String, String, ContentValues, int)}</li>
     * </ul>
     * <p>
     * For UPDATE statements, use any of the following instead.
     * <ul>
     *   <li>{@link #update(String, ContentValues, String, String[])}</li>
     *   <li>{@link #updateWithOnConflict(String, ContentValues, String, String[], int)}</li>
     * </ul>
     * <p>
     * For DELETE statements, use any of the following instead.
     * <ul>
     *   <li>{@link #delete(String, String, String[])}</li>
     * </ul>
     * <p>
     * For example, the following are good candidates for using this method:
     * <ul>
     *   <li>ALTER TABLE</li>
     *   <li>CREATE or DROP table / trigger / view / index / virtual table</li>
     *   <li>REINDEX</li>
     *   <li>RELEASE</li>
     *   <li>SAVEPOINT</li>
     *   <li>PRAGMA that returns no data</li>
     * </ul>
     * </p>
     * <p>
     * When using {@link #enableWriteAheadLogging()}, journal_mode is
     * automatically managed by this class. So, do not set journal_mode
     * using "PRAGMA journal_mode'<value>" statement if your app is using
     * {@link #enableWriteAheadLogging()}
     * </p>
     *
     * @param sql the SQL statement to be executed. Multiple statements separated by semicolons are
     * not supported.
     * @param bindArgs only byte[], String, Long and Double are supported in bindArgs.
     * @throws SQLException if the SQL string is invalid
     */
    public void execSQL(String sql, Object[] bindArgs) throws SQLException {
        if (bindArgs == null) {
            throw new IllegalArgumentException("Empty bindArgs");
        }
        executeSql(sql, bindArgs);
    }


Number 79:
API Relative Path:
src.android.database.sqlite.SQLiteDatabase.java-setLocale(Locale)
Corresponding Source:
/**
     * Sets the locale for this database.  Does nothing if this database has
     * the {@link #NO_LOCALIZED_COLLATORS} flag set or was opened read only.
     *
     * @param locale The new locale.
     *
     * @throws SQLException if the locale could not be set.  The most common reason
     * for this is that there is no collator available for the locale you requested.
     * In this case the database remains unchanged.
     */
    public void setLocale(Locale locale) {
        if (locale == null) {
            throw new IllegalArgumentException("locale must not be null.");
        }

        synchronized (mLock) {
            throwIfNotOpenLocked();

            final Locale oldLocale = mConfigurationLocked.locale;
            mConfigurationLocked.locale = locale;
            try {
                mConnectionPoolLocked.reconfigure(mConfigurationLocked);
            } catch (RuntimeException ex) {
                mConfigurationLocked.locale = oldLocale;
                throw ex;
            }
        }
    }


Number 80:
API Relative Path:
src.android.database.sqlite.SQLiteDatabase.java-setMaxSqlCacheSize(int)
Corresponding Source:
/**
     * Sets the maximum size of the prepared-statement cache for this database.
     * (size of the cache = number of compiled-sql-statements stored in the cache).
     *<p>
     * Maximum cache size can ONLY be increased from its current size (default = 10).
     * If this method is called with smaller size than the current maximum value,
     * then IllegalStateException is thrown.
     *<p>
     * This method is thread-safe.
     *
     * @param cacheSize the size of the cache. can be (0 to {@link #MAX_SQL_CACHE_SIZE})
     * @throws IllegalStateException if input cacheSize > {@link #MAX_SQL_CACHE_SIZE}.
     */
    public void setMaxSqlCacheSize(int cacheSize) {
        if (cacheSize > MAX_SQL_CACHE_SIZE || cacheSize < 0) {
            throw new IllegalStateException(
                    "expected value between 0 and " + MAX_SQL_CACHE_SIZE);
        }

        synchronized (mLock) {
            throwIfNotOpenLocked();

            final int oldMaxSqlCacheSize = mConfigurationLocked.maxSqlCacheSize;
            mConfigurationLocked.maxSqlCacheSize = cacheSize;
            try {
                mConnectionPoolLocked.reconfigure(mConfigurationLocked);
            } catch (RuntimeException ex) {
                mConfigurationLocked.maxSqlCacheSize = oldMaxSqlCacheSize;
                throw ex;
            }
        }
    }


Number 81:
API Relative Path:
src.android.database.sqlite.SQLiteDatabase.java-updateWithOnConflict(String-ContentValues-String-String[]-int)
Corresponding Source:
/**
     * Convenience method for updating rows in the database.
     *
     * @param table the table to update in
     * @param values a map from column names to new column values. null is a
     *            valid value that will be translated to NULL.
     * @param whereClause the optional WHERE clause to apply when updating.
     *            Passing null will update all rows.
     * @param whereArgs You may include ?s in the where clause, which
     *            will be replaced by the values from whereArgs. The values
     *            will be bound as Strings.
     * @param conflictAlgorithm for update conflict resolver
     * @return the number of rows affected
     */
    public int updateWithOnConflict(String table, ContentValues values,
            String whereClause, String[] whereArgs, int conflictAlgorithm) {
        if (values == null || values.size() == 0) {
            throw new IllegalArgumentException("Empty values");
        }

        acquireReference();
        try {
            StringBuilder sql = new StringBuilder(120);
            sql.append("UPDATE ");
            sql.append(CONFLICT_VALUES[conflictAlgorithm]);
            sql.append(table);
            sql.append(" SET ");

            // move all bind args to one array
            int setValuesSize = values.size();
            int bindArgsSize = (whereArgs == null) ? setValuesSize : (setValuesSize + whereArgs.length);
            Object[] bindArgs = new Object[bindArgsSize];
            int i = 0;
            for (String colName : values.keySet()) {
                sql.append((i > 0) ? "," : "");
                sql.append(colName);
                bindArgs[i++] = values.get(colName);
                sql.append("=?");
            }
            if (whereArgs != null) {
                for (i = setValuesSize; i < bindArgsSize; i++) {
                    bindArgs[i] = whereArgs[i - setValuesSize];
                }
            }
            if (!TextUtils.isEmpty(whereClause)) {
                sql.append(" WHERE ");
                sql.append(whereClause);
            }

            SQLiteStatement statement = new SQLiteStatement(this, sql.toString(), bindArgs);
            try {
                return statement.executeUpdateDelete();
            } finally {
                statement.close();
            }
        } finally {
            releaseReference();
        }
    }


Number 82:
API Relative Path:
src.android.database.sqlite.SQLiteDatabaseConfiguration.java-SQLiteDatabaseConfiguration(SQLiteDatabaseConfiguration)
Corresponding Source:
/**
     * Creates a database configuration as a copy of another configuration.
     *
     * @param other The other configuration.
     */
    public SQLiteDatabaseConfiguration(SQLiteDatabaseConfiguration other) {
        if (other == null) {
            throw new IllegalArgumentException("other must not be null.");
        }

        this.path = other.path;
        this.label = other.label;
        updateParametersFrom(other);
    }


Number 83:
API Relative Path:
src.android.database.sqlite.SQLiteDatabaseConfiguration.java-SQLiteDatabaseConfiguration(String-int)
Corresponding Source:
/**
     * Creates a database configuration with the required parameters for opening a
     * database and default values for all other parameters.
     *
     * @param path The database path.
     * @param openFlags Open flags for the database, such as {@link SQLiteDatabase#OPEN_READWRITE}.
     */
    public SQLiteDatabaseConfiguration(String path, int openFlags) {
        if (path == null) {
            throw new IllegalArgumentException("path must not be null.");
        }

        this.path = path;
        label = stripPathForLogs(path);
        this.openFlags = openFlags;

        // Set default values for optional parameters.
        maxSqlCacheSize = 25;
        locale = Locale.getDefault();
    }


Number 84:
API Relative Path:
src.android.database.sqlite.SQLiteDatabaseConfiguration.java-updateParametersFrom(SQLiteDatabaseConfiguration)
Corresponding Source:
/**
     * Updates the non-immutable parameters of this configuration object
     * from the other configuration object.
     *
     * @param other The object from which to copy the parameters.
     */
    public void updateParametersFrom(SQLiteDatabaseConfiguration other) {
        if (other == null) {
            throw new IllegalArgumentException("other must not be null.");
        }
        if (!path.equals(other.path)) {
            throw new IllegalArgumentException("other configuration must refer to "
                    + "the same database.");
        }

        openFlags = other.openFlags;
        maxSqlCacheSize = other.maxSqlCacheSize;
        locale = other.locale;
        foreignKeyConstraintsEnabled = other.foreignKeyConstraintsEnabled;
        customFunctions.clear();
        customFunctions.addAll(other.customFunctions);
    }


Number 85:
API Relative Path:
src.android.database.sqlite.SQLiteOpenHelper.java-SQLiteOpenHelper(Context-String-CursorFactory-int-DatabaseErrorHandler)
Corresponding Source:
/**
     * Create a helper object to create, open, and/or manage a database.
     * The database is not actually created or opened until one of
     * {@link #getWritableDatabase} or {@link #getReadableDatabase} is called.
     *
     * <p>Accepts input param: a concrete instance of {@link DatabaseErrorHandler} to be
     * used to handle corruption when sqlite reports database corruption.</p>
     *
     * @param context to use to open or create the database
     * @param name of the database file, or null for an in-memory database
     * @param factory to use for creating cursor objects, or null for the default
     * @param version number of the database (starting at 1); if the database is older,
     *     {@link #onUpgrade} will be used to upgrade the database; if the database is
     *     newer, {@link #onDowngrade} will be used to downgrade the database
     * @param errorHandler the {@link DatabaseErrorHandler} to be used when sqlite reports database
     * corruption, or null to use the default error handler.
     */
    public SQLiteOpenHelper(Context context, String name, CursorFactory factory, int version,
            DatabaseErrorHandler errorHandler) {
        if (version < 1) throw new IllegalArgumentException("Version must be >= 1, was " + version);

        mContext = context;
        mName = name;
        mFactory = factory;
        mNewVersion = version;
        mErrorHandler = errorHandler;
    }


Number 86:
API Relative Path:
src.android.database.sqlite.SQLiteProgram.java-bindAllArgsAsStrings(String[])
Corresponding Source:
/**
     * Given an array of String bindArgs, this method binds all of them in one single call.
     *
     * @param bindArgs the String array of bind args, none of which must be null.
     */
    public void bindAllArgsAsStrings(String[] bindArgs) {
        if (bindArgs != null) {
            for (int i = bindArgs.length; i != 0; i--) {
                bindString(i, bindArgs[i - 1]);
            }
        }
    }


Number 87:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-execute(String-Object[]-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that does not return a result.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public void execute(String sql, Object[] bindArgs, int connectionFlags,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            return;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            mConnection.execute(sql, bindArgs, cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 88:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForBlobFileDescriptor(String-Object[]-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a single BLOB result as a
     * file descriptor to a shared memory region.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The file descriptor for a shared memory region that contains
     * the value of the first column in the first row of the result set as a BLOB,
     * or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public ParcelFileDescriptor executeForBlobFileDescriptor(String sql, Object[] bindArgs,
            int connectionFlags, CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            return null;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForBlobFileDescriptor(sql, bindArgs,
                    cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 89:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForChangedRowCount(String-Object[]-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a count of the number of rows
     * that were changed.  Use for UPDATE or DELETE SQL statements.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The number of rows that were changed.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public int executeForChangedRowCount(String sql, Object[] bindArgs, int connectionFlags,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            return 0;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForChangedRowCount(sql, bindArgs,
                    cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 90:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForCursorWindow(String-Object[]-CursorWindow-int-int-boolean-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement and populates the specified {@link CursorWindow}
     * with a range of results.  Returns the number of rows that were counted
     * during query execution.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param window The cursor window to clear and fill.
     * @param startPos The start position for filling the window.
     * @param requiredPos The position of a row that MUST be in the window.
     * If it won't fit, then the query should discard part of what it filled
     * so that it does.  Must be greater than or equal to <code>startPos</code>.
     * @param countAllRows True to count all rows that the query would return
     * regagless of whether they fit in the window.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The number of rows that were counted during query execution.  Might
     * not be all rows in the result set unless <code>countAllRows</code> is true.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public int executeForCursorWindow(String sql, Object[] bindArgs,
            CursorWindow window, int startPos, int requiredPos, boolean countAllRows,
            int connectionFlags, CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }
        if (window == null) {
            throw new IllegalArgumentException("window must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            window.clear();
            return 0;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForCursorWindow(sql, bindArgs,
                    window, startPos, requiredPos, countAllRows,
                    cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 91:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForCursorWindow(String-Object[]-CursorWindow-int-int-boolean-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement and populates the specified {@link CursorWindow}
     * with a range of results.  Returns the number of rows that were counted
     * during query execution.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param window The cursor window to clear and fill.
     * @param startPos The start position for filling the window.
     * @param requiredPos The position of a row that MUST be in the window.
     * If it won't fit, then the query should discard part of what it filled
     * so that it does.  Must be greater than or equal to <code>startPos</code>.
     * @param countAllRows True to count all rows that the query would return
     * regagless of whether they fit in the window.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The number of rows that were counted during query execution.  Might
     * not be all rows in the result set unless <code>countAllRows</code> is true.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public int executeForCursorWindow(String sql, Object[] bindArgs,
            CursorWindow window, int startPos, int requiredPos, boolean countAllRows,
            int connectionFlags, CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }
        if (window == null) {
            throw new IllegalArgumentException("window must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            window.clear();
            return 0;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForCursorWindow(sql, bindArgs,
                    window, startPos, requiredPos, countAllRows,
                    cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 92:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForLastInsertedRowId(String-Object[]-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns the row id of the last row inserted
     * by the statement.  Use for INSERT SQL statements.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The row id of the last row that was inserted, or 0 if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public long executeForLastInsertedRowId(String sql, Object[] bindArgs, int connectionFlags,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            return 0;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForLastInsertedRowId(sql, bindArgs,
                    cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 93:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForLong(String-Object[]-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a single <code>long</code> result.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The value of the first column in the first row of the result set
     * as a <code>long</code>, or zero if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public long executeForLong(String sql, Object[] bindArgs, int connectionFlags,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            return 0;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForLong(sql, bindArgs, cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 94:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-executeForString(String-Object[]-int-CancellationSignal)
Corresponding Source:
/**
     * Executes a statement that returns a single {@link String} result.
     *
     * @param sql The SQL statement to execute.
     * @param bindArgs The arguments to bind, or null if none.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @return The value of the first column in the first row of the result set
     * as a <code>String</code>, or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error
     * or invalid number of bind arguments.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public String executeForString(String sql, Object[] bindArgs, int connectionFlags,
            CancellationSignal cancellationSignal) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (executeSpecial(sql, bindArgs, connectionFlags, cancellationSignal)) {
            return null;
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            return mConnection.executeForString(sql, bindArgs, cancellationSignal); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 95:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-prepare(String-int-CancellationSignal-SQLiteStatementInfo)
Corresponding Source:
/**
     * Prepares a statement for execution but does not bind its parameters or execute it.
     * <p>
     * This method can be used to check for syntax errors during compilation
     * prior to execution of the statement.  If the {@code outStatementInfo} argument
     * is not null, the provided {@link SQLiteStatementInfo} object is populated
     * with information about the statement.
     * </p><p>
     * A prepared statement makes no reference to the arguments that may eventually
     * be bound to it, consequently it it possible to cache certain prepared statements
     * such as SELECT or INSERT/UPDATE statements.  If the statement is cacheable,
     * then it will be stored in the cache for later and reused if possible.
     * </p>
     *
     * @param sql The SQL statement to prepare.
     * @param connectionFlags The connection flags to use if a connection must be
     * acquired by this operation.  Refer to {@link SQLiteConnectionPool}.
     * @param cancellationSignal A signal to cancel the operation in progress, or null if none.
     * @param outStatementInfo The {@link SQLiteStatementInfo} object to populate
     * with information about the statement, or null if none.
     *
     * @throws SQLiteException if an error occurs, such as a syntax error.
     * @throws OperationCanceledException if the operation was canceled.
     */
    public void prepare(String sql, int connectionFlags, CancellationSignal cancellationSignal,
            SQLiteStatementInfo outStatementInfo) {
        if (sql == null) {
            throw new IllegalArgumentException("sql must not be null.");
        }

        if (cancellationSignal != null) {
            cancellationSignal.throwIfCanceled();
        }

        acquireConnection(sql, connectionFlags, cancellationSignal); // might throw
        try {
            mConnection.prepare(sql, outStatementInfo); // might throw
        } finally {
            releaseConnection(); // might throw
        }
    }


Number 96:
API Relative Path:
src.android.database.sqlite.SQLiteSession.java-SQLiteSession(SQLiteConnectionPool)
Corresponding Source:
/**
     * Creates a session bound to the specified connection pool.
     *
     * @param connectionPool The connection pool.
     */
    public SQLiteSession(SQLiteConnectionPool connectionPool) {
        if (connectionPool == null) {
            throw new IllegalArgumentException("connectionPool must not be null");
        }

        mConnectionPool = connectionPool;
    }


Number 97:
API Relative Path:
src.android.gesture.GestureStore.java-addGesture(String-Gesture)
Corresponding Source:
/**
     * Add a gesture for the entry
     * 
     * @param entryName entry name
     * @param gesture
     */
    public void addGesture(String entryName, Gesture gesture) {
        if (entryName == null || entryName.length() == 0) {
            return;
        }
        ArrayList<Gesture> gestures = mNamedGestures.get(entryName);
        if (gestures == null) {
            gestures = new ArrayList<Gesture>();
            mNamedGestures.put(entryName, gestures);
        }
        gestures.add(gesture);
        mClassifier.addInstance(
                Instance.createInstance(mSequenceType, mOrientationStyle, gesture, entryName));
        mChanged = true;
    }


Number 98:
API Relative Path:
src.android.gesture.GestureUtils.java-closeStream(Closeable)
Corresponding Source:
/**
     * Closes the specified stream.
     *
     * @param stream The stream to close.
     */
    static void closeStream(Closeable stream) {
        if (stream != null) {
            try {
                stream.close();
            } catch (IOException e) {
                Log.e(LOG_TAG, "Could not close stream", e);
            }
        }
    }


Number 99:
API Relative Path:
src.android.graphics.AvoidXfermode.java-AvoidXfermode(int-int-Mode)
Corresponding Source:
/** This xfermode draws, or doesn't draw, based on the destination's
     * distance from an op-color.
     *
     * There are two modes, and each mode interprets a tolerance value.
     *
     * Avoid: In this mode, drawing is allowed only on destination pixels that
     * are different from the op-color.
     * Tolerance near 0: avoid any colors even remotely similar to the op-color
     * Tolerance near 255: avoid only colors nearly identical to the op-color
     
     * Target: In this mode, drawing only occurs on destination pixels that
     * are similar to the op-color
     * Tolerance near 0: draw only on colors that are nearly identical to the op-color
     * Tolerance near 255: draw on any colors even remotely similar to the op-color
     */
    public AvoidXfermode(int opColor, int tolerance, Mode mode) {
        if (tolerance < 0 || tolerance > 255) {
            throw new IllegalArgumentException("tolerance must be 0..255");
        }
    }


Number 100:
API Relative Path:
src.android.graphics.Bitmap.java-compress(CompressFormat-int-OutputStream)
Corresponding Source:
/**
     * Write a compressed version of the bitmap to the specified outputstream.
     * If this returns true, the bitmap can be reconstructed by passing a
     * corresponding inputstream to BitmapFactory.decodeStream(). Note: not
     * all Formats support all bitmap configs directly, so it is possible that
     * the returned bitmap from BitmapFactory could be in a different bitdepth,
     * and/or may have lost per-pixel alpha (e.g. JPEG only supports opaque
     * pixels).
     *
     * @param format   The format of the compressed image
     * @param quality  Hint to the compressor, 0-100. 0 meaning compress for
     *                 small size, 100 meaning compress for max quality. Some
     *                 formats, like PNG which is lossless, will ignore the
     *                 quality setting
     * @param stream   The outputstream to write the compressed data.
     * @return true if successfully compressed to the specified stream.
     */
    public boolean compress(CompressFormat format, int quality, OutputStream stream) {
        checkRecycled("Can't compress a recycled bitmap");
        // do explicit check before calling the native method
        if (stream == null) {
            throw new NullPointerException();
        }
        if (quality < 0 || quality > 100) {
            throw new IllegalArgumentException("quality must be 0..100");
        }
        Trace.traceBegin(Trace.TRACE_TAG_RESOURCES, "Bitmap.compress");
        boolean result = nativeCompress(mNativePtr, format.nativeInt,
                quality, stream, new byte[WORKING_COMPRESS_STORAGE]);
        Trace.traceEnd(Trace.TRACE_TAG_RESOURCES);
        return result;
    }


Number 101:
API Relative Path:
src.android.graphics.Bitmap.java-compress(CompressFormat-int-OutputStream)
Corresponding Source:
/**
     * Write a compressed version of the bitmap to the specified outputstream.
     * If this returns true, the bitmap can be reconstructed by passing a
     * corresponding inputstream to BitmapFactory.decodeStream(). Note: not
     * all Formats support all bitmap configs directly, so it is possible that
     * the returned bitmap from BitmapFactory could be in a different bitdepth,
     * and/or may have lost per-pixel alpha (e.g. JPEG only supports opaque
     * pixels).
     *
     * @param format   The format of the compressed image
     * @param quality  Hint to the compressor, 0-100. 0 meaning compress for
     *                 small size, 100 meaning compress for max quality. Some
     *                 formats, like PNG which is lossless, will ignore the
     *                 quality setting
     * @param stream   The outputstream to write the compressed data.
     * @return true if successfully compressed to the specified stream.
     */
    public boolean compress(CompressFormat format, int quality, OutputStream stream) {
        checkRecycled("Can't compress a recycled bitmap");
        // do explicit check before calling the native method
        if (stream == null) {
            throw new NullPointerException();
        }
        if (quality < 0 || quality > 100) {
            throw new IllegalArgumentException("quality must be 0..100");
        }
        Trace.traceBegin(Trace.TRACE_TAG_RESOURCES, "Bitmap.compress");
        boolean result = nativeCompress(mNativePtr, format.nativeInt,
                quality, stream, new byte[WORKING_COMPRESS_STORAGE]);
        Trace.traceEnd(Trace.TRACE_TAG_RESOURCES);
        return result;
    }


Number 102:
API Relative Path:
src.android.graphics.Bitmap.java-copyPixelsFromBuffer(Buffer)
Corresponding Source:
/**
     * <p>Copy the pixels from the buffer, beginning at the current position,
     * overwriting the bitmap's pixels. The data in the buffer is not changed
     * in any way (unlike setPixels(), which converts from unpremultipled 32bit
     * to whatever the bitmap's native format is.</p>
     * <p>After this method returns, the current position of the buffer is
     * updated: the position is incremented by the number of elements read from
     * the buffer. If you need to read the bitmap from the buffer again you must
     * first rewind the buffer.</p>
     */
    public void copyPixelsFromBuffer(Buffer src) {
        checkRecycled("copyPixelsFromBuffer called on recycled bitmap");

        int elements = src.remaining();
        int shift;
        if (src instanceof ByteBuffer) {
            shift = 0;
        } else if (src instanceof ShortBuffer) {
            shift = 1;
        } else if (src instanceof IntBuffer) {
            shift = 2;
        } else {
            throw new RuntimeException("unsupported Buffer subclass");
        }

        long bufferBytes = (long) elements << shift;
        long bitmapBytes = getByteCount();

        if (bufferBytes < bitmapBytes) {
            throw new RuntimeException("Buffer not large enough for pixels");
        }

        nativeCopyPixelsFromBuffer(mNativePtr, src);

        // now update the buffer's position
        int position = src.position();
        position += bitmapBytes >> shift;
        src.position(position);
    }


Number 103:
API Relative Path:
src.android.graphics.Bitmap.java-copyPixelsToBuffer(Buffer)
Corresponding Source:
/**
     * <p>Copy the bitmap's pixels into the specified buffer (allocated by the
     * caller). An exception is thrown if the buffer is not large enough to
     * hold all of the pixels (taking into account the number of bytes per
     * pixel) or if the Buffer subclass is not one of the support types
     * (ByteBuffer, ShortBuffer, IntBuffer).</p>
     * <p>The content of the bitmap is copied into the buffer as-is. This means
     * that if this bitmap stores its pixels pre-multiplied
     * (see {@link #isPremultiplied()}, the values in the buffer will also be
     * pre-multiplied.</p>
     * <p>After this method returns, the current position of the buffer is
     * updated: the position is incremented by the number of elements written
     * in the buffer.</p>
     */
    public void copyPixelsToBuffer(Buffer dst) {
        int elements = dst.remaining();
        int shift;
        if (dst instanceof ByteBuffer) {
            shift = 0;
        } else if (dst instanceof ShortBuffer) {
            shift = 1;
        } else if (dst instanceof IntBuffer) {
            shift = 2;
        } else {
            throw new RuntimeException("unsupported Buffer subclass");
        }

        long bufferSize = (long)elements << shift;
        long pixelSize = getByteCount();

        if (bufferSize < pixelSize) {
            throw new RuntimeException("Buffer not large enough for pixels");
        }

        nativeCopyPixelsToBuffer(mNativePtr, dst);

        // now update the buffer's position
        int position = dst.position();
        position += pixelSize >> shift;
        dst.position(position);
    }


Number 104:
API Relative Path:
src.android.graphics.Bitmap.java-createBitmap(DisplayMetrics-int-int-int-int-int-Config)
Corresponding Source:
/**
     * Returns a immutable bitmap with the specified width and height, with each
     * pixel value set to the corresponding value in the colors array.  Its
     * initial density is determined from the given {@link DisplayMetrics}.
     *
     * @param display  Display metrics for the display this bitmap will be
     *                 drawn on.
     * @param colors   Array of {@link Color} used to initialize the pixels.
     * @param offset   Number of values to skip before the first color in the
     *                 array of colors.
     * @param stride   Number of colors in the array between rows (must be >=
     *                 width or <= -width).
     * @param width    The width of the bitmap
     * @param height   The height of the bitmap
     * @param config   The bitmap config to create. If the config does not
     *                 support per-pixel alpha (e.g. RGB_565), then the alpha
     *                 bytes in the colors[] will be ignored (assumed to be FF)
     * @throws IllegalArgumentException if the width or height are <= 0, or if
     *         the color array's length is less than the number of pixels.
     */
    public static Bitmap createBitmap(DisplayMetrics display, int colors[],
            int offset, int stride, int width, int height, Config config) {

        checkWidthHeight(width, height);
        if (Math.abs(stride) < width) {
            throw new IllegalArgumentException("abs(stride) must be >= width");
        }
        int lastScanline = offset + (height - 1) * stride;
        int length = colors.length;
        if (offset < 0 || (offset + width > length) || lastScanline < 0 ||
                (lastScanline + width > length)) {
            throw new ArrayIndexOutOfBoundsException();
        }
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("width and height must be > 0");
        }
        Bitmap bm = nativeCreate(colors, offset, stride, width, height,
                            config.nativeInt, false);
        if (display != null) {
            bm.mDensity = display.densityDpi;
        }
        return bm;
    }


Number 105:
API Relative Path:
src.android.graphics.Bitmap.java-reconfigure(int-int-Config)
Corresponding Source:
/**
     * <p>Modifies the bitmap to have a specified width, height, and {@link
     * Config}, without affecting the underlying allocation backing the bitmap.
     * Bitmap pixel data is not re-initialized for the new configuration.</p>
     *
     * <p>This method can be used to avoid allocating a new bitmap, instead
     * reusing an existing bitmap's allocation for a new configuration of equal
     * or lesser size. If the Bitmap's allocation isn't large enough to support
     * the new configuration, an IllegalArgumentException will be thrown and the
     * bitmap will not be modified.</p>
     *
     * <p>The result of {@link #getByteCount()} will reflect the new configuration,
     * while {@link #getAllocationByteCount()} will reflect that of the initial
     * configuration.</p>
     *
     * <p>Note: This may change this result of hasAlpha(). When converting to 565,
     * the new bitmap will always be considered opaque. When converting from 565,
     * the new bitmap will be considered non-opaque, and will respect the value
     * set by setPremultiplied().</p>
     *
     * <p>WARNING: This method should NOT be called on a bitmap currently in use
     * by the view system, Canvas, or the AndroidBitmap NDK API. It does not
     * make guarantees about how the underlying pixel buffer is remapped to the
     * new config, just that the allocation is reused. Additionally, the view
     * system does not account for bitmap properties being modifying during use,
     * e.g. while attached to drawables.</p>
     *
     * <p>In order to safely ensure that a Bitmap is no longer in use by the
     * View system it is necessary to wait for a draw pass to occur after
     * invalidate()'ing any view that had previously drawn the Bitmap in the last
     * draw pass due to hardware acceleration's caching of draw commands. As
     * an example, here is how this can be done for an ImageView:
     * <pre class="prettyprint">
     *      ImageView myImageView = ...;
     *      final Bitmap myBitmap = ...;
     *      myImageView.setImageDrawable(null);
     *      myImageView.post(new Runnable() {
     *          public void run() {
     *              // myBitmap is now no longer in use by the ImageView
     *              // and can be safely reconfigured.
     *              myBitmap.reconfigure(...);
     *          }
     *      });
     * </pre></p>
     *
     * @see #setWidth(int)
     * @see #setHeight(int)
     * @see #setConfig(Config)
     */
    public void reconfigure(int width, int height, Config config) {
        checkRecycled("Can't call reconfigure() on a recycled bitmap");
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("width and height must be > 0");
        }
        if (!isMutable()) {
            throw new IllegalStateException("only mutable bitmaps may be reconfigured");
        }
        if (mBuffer == null) {
            throw new IllegalStateException("native-backed bitmaps may not be reconfigured");
        }

        nativeReconfigure(mNativePtr, width, height, config.nativeInt,
                mBuffer.length, mRequestPremultiplied);
        mWidth = width;
        mHeight = height;
    }


Number 106:
API Relative Path:
src.android.graphics.BitmapFactory.java-decodeByteArray(byte[]-int-int-Options)
Corresponding Source:
private static native Bitmap nativeDecodeByteArray(byte[] data, int offset,
            int length, Options opts);


Number 107:
API Relative Path:
src.android.graphics.BitmapFactory.java-decodeStream(InputStream-Rect-Options)
Corresponding Source:
/**
     * Decode an input stream into a bitmap. If the input stream is null, or
     * cannot be used to decode a bitmap, the function returns null.
     * The stream's position will be where ever it was after the encoded data
     * was read.
     *
     * @param is The input stream that holds the raw data to be decoded into a
     *           bitmap.
     * @param outPadding If not null, return the padding rect for the bitmap if
     *                   it exists, otherwise set padding to [-1,-1,-1,-1]. If
     *                   no bitmap is returned (null) then padding is
     *                   unchanged.
     * @param opts null-ok; Options that control downsampling and whether the
     *             image should be completely decoded, or just is size returned.
     * @return The decoded bitmap, or null if the image data could not be
     *         decoded, or, if opts is non-null, if opts requested only the
     *         size be returned (in opts.outWidth and opts.outHeight)
     *
     * <p class="note">Prior to {@link android.os.Build.VERSION_CODES#KITKAT},
     * if {@link InputStream#markSupported is.markSupported()} returns true,
     * <code>is.mark(1024)</code> would be called. As of
     * {@link android.os.Build.VERSION_CODES#KITKAT}, this is no longer the case.</p>
     */
    public static Bitmap decodeStream(InputStream is, Rect outPadding, Options opts) {
        // we don't throw in this case, thus allowing the caller to only check
        // the cache, and not force the image to be decoded.
        if (is == null) {
            return null;
        }

        Bitmap bm = null;

        Trace.traceBegin(Trace.TRACE_TAG_GRAPHICS, "decodeBitmap");
        try {
            if (is instanceof AssetManager.AssetInputStream) {
                final long asset = ((AssetManager.AssetInputStream) is).getNativeAsset();
                bm = nativeDecodeAsset(asset, outPadding, opts);
            } else {
                bm = decodeStreamInternal(is, outPadding, opts);
            }

            if (bm == null && opts != null && opts.inBitmap != null) {
                throw new IllegalArgumentException("Problem decoding into existing bitmap");
            }

            setDensityFromOptions(bm, opts);
        } finally {
            Trace.traceEnd(Trace.TRACE_TAG_GRAPHICS);
        }

        return bm;
    }


Number 108:
API Relative Path:
src.android.graphics.BitmapRegionDecoder.java-newInstance(byte[]-int-int-boolean)
Corresponding Source:
private static native BitmapRegionDecoder nativeNewInstance(
            byte[] data, int offset, int length, boolean isShareable);


Number 109:
API Relative Path:
src.android.graphics.Canvas.java-Canvas(long)
Corresponding Source:
/** @hide */
    public Canvas(long nativeCanvas) {
        if (nativeCanvas == 0) {
            throw new IllegalStateException();
        }
        mNativeCanvasWrapper = nativeCanvas;
        mFinalizer = NoImagePreloadHolder.sRegistry.registerNativeAllocation(
                this, mNativeCanvasWrapper);
        mDensity = Bitmap.getDefaultDensity();
    }


Number 110:
API Relative Path:
src.android.graphics.Canvas.java-checkRange(int-int-int)
Corresponding Source:
/**
     * @hide
     */
    protected static void checkRange(int length, int offset, int count) {
        if ((offset | count) < 0 || offset + count > length) {
            throw new ArrayIndexOutOfBoundsException();
        }
    }


Number 111:
API Relative Path:
src.android.graphics.Canvas.java-concat(Matrix)
Corresponding Source:
/**
     * Preconcat the current matrix with the specified matrix. If the specified
     * matrix is null, this method does nothing.
     *
     * @param matrix The matrix to preconcatenate with the current matrix
     */
    public void concat(@Nullable Matrix matrix) {
        if (matrix != null) native_concat(mNativeCanvasWrapper, matrix.native_instance);
    }


Number 112:
API Relative Path:
src.android.graphics.Canvas.java-drawBitmap(Bitmap-Rect-Rect-Paint)
Corresponding Source:
/**
     * Draw the specified bitmap, scaling/translating automatically to fill
     * the destination rectangle. If the source rectangle is not null, it
     * specifies the subset of the bitmap to draw.
     *
     * <p>Note: if the paint contains a maskfilter that generates a mask which
     * extends beyond the bitmap's original width/height (e.g. BlurMaskFilter),
     * then the bitmap will be drawn as if it were in a Shader with CLAMP mode.
     * Thus the color outside of the original width/height will be the edge
     * color replicated.
     *
     * <p>This function <em>ignores the density associated with the bitmap</em>.
     * This is because the source and destination rectangle coordinate
     * spaces are in their respective densities, so must already have the
     * appropriate scaling factor applied.
     *
     * @param bitmap The bitmap to be drawn
     * @param src    May be null. The subset of the bitmap to be drawn
     * @param dst    The rectangle that the bitmap will be scaled/translated
     *               to fit into
     * @param paint  May be null. The paint used to draw the bitmap
     */
    public void drawBitmap(@NonNull Bitmap bitmap, @Nullable Rect src, @NonNull Rect dst,
            @Nullable Paint paint) {
        if (dst == null) {
            throw new NullPointerException();
        }
        throwIfCannotDraw(bitmap);
        final long nativePaint = paint == null ? 0 : paint.getNativeInstance();

        int left, top, right, bottom;
        if (src == null) {
            left = top = 0;
            right = bitmap.getWidth();
            bottom = bitmap.getHeight();
        } else {
            left = src.left;
            right = src.right;
            top = src.top;
            bottom = src.bottom;
        }

        native_drawBitmap(mNativeCanvasWrapper, bitmap, left, top, right, bottom,
            dst.left, dst.top, dst.right, dst.bottom, nativePaint, mScreenDensity,
            bitmap.mDensity);
    }


Number 113:
API Relative Path:
src.android.graphics.Canvas.java-drawBitmap(Bitmap-Rect-RectF-Paint)
Corresponding Source:
/**
     * Draw the specified bitmap, scaling/translating automatically to fill
     * the destination rectangle. If the source rectangle is not null, it
     * specifies the subset of the bitmap to draw.
     *
     * <p>Note: if the paint contains a maskfilter that generates a mask which
     * extends beyond the bitmap's original width/height (e.g. BlurMaskFilter),
     * then the bitmap will be drawn as if it were in a Shader with CLAMP mode.
     * Thus the color outside of the original width/height will be the edge
     * color replicated.
     *
     * <p>This function <em>ignores the density associated with the bitmap</em>.
     * This is because the source and destination rectangle coordinate
     * spaces are in their respective densities, so must already have the
     * appropriate scaling factor applied.
     *
     * @param bitmap The bitmap to be drawn
     * @param src    May be null. The subset of the bitmap to be drawn
     * @param dst    The rectangle that the bitmap will be scaled/translated
     *               to fit into
     * @param paint  May be null. The paint used to draw the bitmap
     */
    public void drawBitmap(@NonNull Bitmap bitmap, @Nullable Rect src, @NonNull RectF dst,
            @Nullable Paint paint) {
      if (dst == null) {
          throw new NullPointerException();
      }
      throwIfCannotDraw(bitmap);
      final long nativePaint = paint == null ? 0 : paint.getNativeInstance();

      float left, top, right, bottom;
      if (src == null) {
          left = top = 0;
          right = bitmap.getWidth();
          bottom = bitmap.getHeight();
      } else {
          left = src.left;
          right = src.right;
          top = src.top;
          bottom = src.bottom;
      }

      native_drawBitmap(mNativeCanvasWrapper, bitmap, left, top, right, bottom,
              dst.left, dst.top, dst.right, dst.bottom, nativePaint, mScreenDensity,
              bitmap.mDensity);
  }


Number 114:
API Relative Path:
src.android.graphics.Canvas.java-drawBitmap(int[]-int-int-float-float-int-int-boolean-Paint)
Corresponding Source:
/**
     * Treat the specified array of colors as a bitmap, and draw it. This gives
     * the same result as first creating a bitmap from the array, and then
     * drawing it, but this method avoids explicitly creating a bitmap object
     * which can be more efficient if the colors are changing often.
     *
     * @param colors Array of colors representing the pixels of the bitmap
     * @param offset Offset into the array of colors for the first pixel
     * @param stride The number of colors in the array between rows (must be
     *               >= width or <= -width).
     * @param x The X coordinate for where to draw the bitmap
     * @param y The Y coordinate for where to draw the bitmap
     * @param width The width of the bitmap
     * @param height The height of the bitmap
     * @param hasAlpha True if the alpha channel of the colors contains valid
     *                 values. If false, the alpha byte is ignored (assumed to
     *                 be 0xFF for every pixel).
     * @param paint  May be null. The paint used to draw the bitmap
     *
     * @deprecated Usage with a {@link #isHardwareAccelerated() hardware accelerated} canvas
     * requires an internal copy of color buffer contents every time this method is called. Using a
     * Bitmap avoids this copy, and allows the application to more explicitly control the lifetime
     * and copies of pixel data.
     */
    @Deprecated
    public void drawBitmap(@NonNull int[] colors, int offset, int stride, float x, float y,
            int width, int height, boolean hasAlpha, @Nullable Paint paint) {
        // check for valid input
        if (width < 0) {
            throw new IllegalArgumentException("width must be >= 0");
        }
        if (height < 0) {
            throw new IllegalArgumentException("height must be >= 0");
        }
        if (Math.abs(stride) < width) {
            throw new IllegalArgumentException("abs(stride) must be >= width");
        }
        int lastScanline = offset + (height - 1) * stride;
        int length = colors.length;
        if (offset < 0 || (offset + width > length) || lastScanline < 0
                || (lastScanline + width > length)) {
            throw new ArrayIndexOutOfBoundsException();
        }
        // quick escape if there's nothing to draw
        if (width == 0 || height == 0) {
            return;
        }
        // punch down to native for the actual draw
        native_drawBitmap(mNativeCanvasWrapper, colors, offset, stride, x, y, width, height, hasAlpha,
                paint != null ? paint.getNativeInstance() : 0);
    }


Number 115:
API Relative Path:
src.android.graphics.Canvas.java-drawBitmap(int[]-int-int-float-float-int-int-boolean-Paint)
Corresponding Source:
/**
     * Treat the specified array of colors as a bitmap, and draw it. This gives
     * the same result as first creating a bitmap from the array, and then
     * drawing it, but this method avoids explicitly creating a bitmap object
     * which can be more efficient if the colors are changing often.
     *
     * @param colors Array of colors representing the pixels of the bitmap
     * @param offset Offset into the array of colors for the first pixel
     * @param stride The number of colors in the array between rows (must be
     *               >= width or <= -width).
     * @param x The X coordinate for where to draw the bitmap
     * @param y The Y coordinate for where to draw the bitmap
     * @param width The width of the bitmap
     * @param height The height of the bitmap
     * @param hasAlpha True if the alpha channel of the colors contains valid
     *                 values. If false, the alpha byte is ignored (assumed to
     *                 be 0xFF for every pixel).
     * @param paint  May be null. The paint used to draw the bitmap
     *
     * @deprecated Usage with a {@link #isHardwareAccelerated() hardware accelerated} canvas
     * requires an internal copy of color buffer contents every time this method is called. Using a
     * Bitmap avoids this copy, and allows the application to more explicitly control the lifetime
     * and copies of pixel data.
     */
    @Deprecated
    public void drawBitmap(@NonNull int[] colors, int offset, int stride, float x, float y,
            int width, int height, boolean hasAlpha, @Nullable Paint paint) {
        // check for valid input
        if (width < 0) {
            throw new IllegalArgumentException("width must be >= 0");
        }
        if (height < 0) {
            throw new IllegalArgumentException("height must be >= 0");
        }
        if (Math.abs(stride) < width) {
            throw new IllegalArgumentException("abs(stride) must be >= width");
        }
        int lastScanline = offset + (height - 1) * stride;
        int length = colors.length;
        if (offset < 0 || (offset + width > length) || lastScanline < 0
                || (lastScanline + width > length)) {
            throw new ArrayIndexOutOfBoundsException();
        }
        // quick escape if there's nothing to draw
        if (width == 0 || height == 0) {
            return;
        }
        // punch down to native for the actual draw
        native_drawBitmap(mNativeCanvasWrapper, colors, offset, stride, x, y, width, height, hasAlpha,
                paint != null ? paint.getNativeInstance() : 0);
    }


Number 116:
API Relative Path:
src.android.graphics.Canvas.java-drawBitmap(int[]-int-int-float-float-int-int-boolean-Paint)
Corresponding Source:
/**
     * Treat the specified array of colors as a bitmap, and draw it. This gives
     * the same result as first creating a bitmap from the array, and then
     * drawing it, but this method avoids explicitly creating a bitmap object
     * which can be more efficient if the colors are changing often.
     *
     * @param colors Array of colors representing the pixels of the bitmap
     * @param offset Offset into the array of colors for the first pixel
     * @param stride The number of colors in the array between rows (must be
     *               >= width or <= -width).
     * @param x The X coordinate for where to draw the bitmap
     * @param y The Y coordinate for where to draw the bitmap
     * @param width The width of the bitmap
     * @param height The height of the bitmap
     * @param hasAlpha True if the alpha channel of the colors contains valid
     *                 values. If false, the alpha byte is ignored (assumed to
     *                 be 0xFF for every pixel).
     * @param paint  May be null. The paint used to draw the bitmap
     *
     * @deprecated Usage with a {@link #isHardwareAccelerated() hardware accelerated} canvas
     * requires an internal copy of color buffer contents every time this method is called. Using a
     * Bitmap avoids this copy, and allows the application to more explicitly control the lifetime
     * and copies of pixel data.
     */
    @Deprecated
    public void drawBitmap(@NonNull int[] colors, int offset, int stride, float x, float y,
            int width, int height, boolean hasAlpha, @Nullable Paint paint) {
        // check for valid input
        if (width < 0) {
            throw new IllegalArgumentException("width must be >= 0");
        }
        if (height < 0) {
            throw new IllegalArgumentException("height must be >= 0");
        }
        if (Math.abs(stride) < width) {
            throw new IllegalArgumentException("abs(stride) must be >= width");
        }
        int lastScanline = offset + (height - 1) * stride;
        int length = colors.length;
        if (offset < 0 || (offset + width > length) || lastScanline < 0
                || (lastScanline + width > length)) {
            throw new ArrayIndexOutOfBoundsException();
        }
        // quick escape if there's nothing to draw
        if (width == 0 || height == 0) {
            return;
        }
        // punch down to native for the actual draw
        native_drawBitmap(mNativeCanvasWrapper, colors, offset, stride, x, y, width, height, hasAlpha,
                paint != null ? paint.getNativeInstance() : 0);
    }


Number 117:
API Relative Path:
src.android.graphics.Canvas.java-drawBitmapMesh(Bitmap-int-int-float[]-int-int[]-int-Paint)
Corresponding Source:
/**
     * Draw the bitmap through the mesh, where mesh vertices are evenly
     * distributed across the bitmap. There are meshWidth+1 vertices across, and
     * meshHeight+1 vertices down. The verts array is accessed in row-major
     * order, so that the first meshWidth+1 vertices are distributed across the
     * top of the bitmap from left to right. A more general version of this
     * method is drawVertices().
     *
     * @param bitmap The bitmap to draw using the mesh
     * @param meshWidth The number of columns in the mesh. Nothing is drawn if
     *                  this is 0
     * @param meshHeight The number of rows in the mesh. Nothing is drawn if
     *                   this is 0
     * @param verts Array of x,y pairs, specifying where the mesh should be
     *              drawn. There must be at least
     *              (meshWidth+1) * (meshHeight+1) * 2 + vertOffset values
     *              in the array
     * @param vertOffset Number of verts elements to skip before drawing
     * @param colors May be null. Specifies a color at each vertex, which is
     *               interpolated across the cell, and whose values are
     *               multiplied by the corresponding bitmap colors. If not null,
     *               there must be at least (meshWidth+1) * (meshHeight+1) +
     *               colorOffset values in the array.
     * @param colorOffset Number of color elements to skip before drawing
     * @param paint  May be null. The paint used to draw the bitmap
     */
    public void drawBitmapMesh(@NonNull Bitmap bitmap, int meshWidth, int meshHeight,
            @NonNull float[] verts, int vertOffset, @Nullable int[] colors, int colorOffset,
            @Nullable Paint paint) {
        if ((meshWidth | meshHeight | vertOffset | colorOffset) < 0) {
            throw new ArrayIndexOutOfBoundsException();
        }
        if (meshWidth == 0 || meshHeight == 0) {
            return;
        }
        int count = (meshWidth + 1) * (meshHeight + 1);
        // we mul by 2 since we need two floats per vertex
        checkRange(verts.length, vertOffset, count * 2);
        if (colors != null) {
            // no mul by 2, since we need only 1 color per vertex
            checkRange(colors.length, colorOffset, count);
        }
        nativeDrawBitmapMesh(mNativeCanvasWrapper, bitmap, meshWidth, meshHeight,
                verts, vertOffset, colors, colorOffset,
                paint != null ? paint.getNativeInstance() : 0);
    }


Number 118:
API Relative Path:
src.android.graphics.Canvas.java-drawOval(RectF-Paint)
Corresponding Source:
/**
     * Draw the specified oval using the specified paint. The oval will be
     * filled or framed based on the Style in the paint.
     *
     * @param oval The rectangle bounds of the oval to be drawn
     */
    public void drawOval(@NonNull RectF oval, @NonNull Paint paint) {
        if (oval == null) {
            throw new NullPointerException();
        }
        drawOval(oval.left, oval.top, oval.right, oval.bottom, paint);
    }


Number 119:
API Relative Path:
src.android.graphics.Canvas.java-drawPosText(char[]-int-int-float[]-Paint)
Corresponding Source:
/**
     * Draw the text in the array, with each character's origin specified by
     * the pos array.
     *
     * @param text     The text to be drawn
     * @param index    The index of the first character to draw
     * @param count    The number of characters to draw, starting from index.
     * @param pos      Array of [x,y] positions, used to position each
     *                 character
     * @param paint    The paint used for the text (e.g. color, size, style)
     *
     * @deprecated This method does not support glyph composition and decomposition and
     * should therefore not be used to render complex scripts. It also doesn't
     * handle supplementary characters (eg emoji).
     */
    @Deprecated
    public void drawPosText(@NonNull char[] text, int index, int count,
            @NonNull @Size(multiple=2) float[] pos,
            @NonNull Paint paint) {
        if (index < 0 || index + count > text.length || count*2 > pos.length) {
            throw new IndexOutOfBoundsException();
        }
        for (int i = 0; i < count; i++) {
            drawText(text, index + i, 1, pos[i * 2], pos[i * 2 + 1], paint);
        }
    }


Number 120:
API Relative Path:
src.android.graphics.Canvas.java-drawText(char[]-int-int-float-float-Paint)
Corresponding Source:
/**
     * Draw the specified range of text, specified by start/end, with its
     * origin at (x,y), in the specified Paint. The origin is interpreted
     * based on the Align setting in the Paint.
     *
     * @param text     The text to be drawn
     * @param start    The index of the first character in text to draw
     * @param end      (end - 1) is the index of the last character in text
     *                 to draw
     * @param x        The x-coordinate of origin for where to draw the text
     * @param y        The y-coordinate of origin for where to draw the text
     * @param paint The paint used for the text (e.g. color, size, style)
     */
    public void drawText(@NonNull CharSequence text, int start, int end, float x, float y,
            @NonNull Paint paint) {
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }
        if (text instanceof String || text instanceof SpannedString ||
            text instanceof SpannableString) {
            native_drawText(mNativeCanvasWrapper, text.toString(), start, end, x, y,
                    paint.mBidiFlags, paint.getNativeInstance(), paint.mNativeTypeface);
        } else if (text instanceof GraphicsOperations) {
            ((GraphicsOperations) text).drawText(this, start, end, x, y,
                    paint);
        } else {
            char[] buf = TemporaryBuffer.obtain(end - start);
            TextUtils.getChars(text, start, end, buf, 0);
            native_drawText(mNativeCanvasWrapper, buf, 0, end - start, x, y,
                    paint.mBidiFlags, paint.getNativeInstance(), paint.mNativeTypeface);
            TemporaryBuffer.recycle(buf);
        }
    }


Number 121:
API Relative Path:
src.android.graphics.Canvas.java-drawTextOnPath(char[]-int-int-Path-float-float-Paint)
Corresponding Source:
/**
     * Draw the text, with origin at (x,y), using the specified paint, along
     * the specified path. The paint's Align setting determins where along the
     * path to start the text.
     *
     * @param text     The text to be drawn
     * @param path     The path the text should follow for its baseline
     * @param hOffset  The distance along the path to add to the text's
     *                 starting position
     * @param vOffset  The distance above(-) or below(+) the path to position
     *                 the text
     * @param paint    The paint used for the text (e.g. color, size, style)
     */
    public void drawTextOnPath(@NonNull char[] text, int index, int count, @NonNull Path path,
            float hOffset, float vOffset, @NonNull Paint paint) {
        if (index < 0 || index + count > text.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        native_drawTextOnPath(mNativeCanvasWrapper, text, index, count,
                path.ni(), hOffset, vOffset,
                paint.mBidiFlags, paint.getNativeInstance(), paint.mNativeTypeface);
    }


Number 122:
API Relative Path:
src.android.graphics.Canvas.java-drawTextRun(CharSequence-int-int-int-int-float-float-boolean-Paint)
Corresponding Source:
/**
     * Draw a run of text, all in a single direction, with optional context for complex text
     * shaping.
     *
     * <p>The run of text includes the characters from {@code start} to {@code end} in the text. In
     * addition, the range {@code contextStart} to {@code contextEnd} is used as context for the
     * purpose of complex text shaping, such as Arabic text potentially shaped differently based on
     * the text next to it.
     *
     * <p>All text outside the range {@code contextStart..contextEnd} is ignored. The text between
     * {@code start} and {@code end} will be laid out and drawn.
     *
     * <p>The direction of the run is explicitly specified by {@code isRtl}. Thus, this method is
     * suitable only for runs of a single direction. Alignment of the text is as determined by the
     * Paint's TextAlign value. Further, {@code 0 <= contextStart <= start <= end <= contextEnd
     * <= text.length} must hold on entry.
     *
     * <p>Also see {@link android.graphics.Paint#getRunAdvance} for a corresponding method to
     * measure the text; the advance width of the text drawn matches the value obtained from that
     * method.
     *
     * @param text the text to render
     * @param start the start of the text to render. Data before this position
     *            can be used for shaping context.
     * @param end the end of the text to render. Data at or after this
     *            position can be used for shaping context.
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index of the end of the shaping context
     * @param x the x position at which to draw the text
     * @param y the y position at which to draw the text
     * @param isRtl whether the run is in RTL direction
     * @param paint the paint
     *
     * @see #drawTextRun(char[], int, int, int, int, float, float, boolean, Paint)
     */
    public void drawTextRun(@NonNull CharSequence text, int start, int end, int contextStart,
            int contextEnd, float x, float y, boolean isRtl, @NonNull Paint paint) {

        if (text == null) {
            throw new NullPointerException("text is null");
        }
        if (paint == null) {
            throw new NullPointerException("paint is null");
        }
        if ((start | end | contextStart | contextEnd | start - contextStart | end - start
                | contextEnd - end | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String || text instanceof SpannedString ||
                text instanceof SpannableString) {
            native_drawTextRun(mNativeCanvasWrapper, text.toString(), start, end, contextStart,
                    contextEnd, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
        } else if (text instanceof GraphicsOperations) {
            ((GraphicsOperations) text).drawTextRun(this, start, end,
                    contextStart, contextEnd, x, y, isRtl, paint);
        } else {
            int contextLen = contextEnd - contextStart;
            int len = end - start;
            char[] buf = TemporaryBuffer.obtain(contextLen);
            TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
            native_drawTextRun(mNativeCanvasWrapper, buf, start - contextStart, len,
                    0, contextLen, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
            TemporaryBuffer.recycle(buf);
        }
    }


Number 123:
API Relative Path:
src.android.graphics.Canvas.java-drawTextRun(CharSequence-int-int-int-int-float-float-boolean-Paint)
Corresponding Source:
/**
     * Draw a run of text, all in a single direction, with optional context for complex text
     * shaping.
     *
     * <p>The run of text includes the characters from {@code start} to {@code end} in the text. In
     * addition, the range {@code contextStart} to {@code contextEnd} is used as context for the
     * purpose of complex text shaping, such as Arabic text potentially shaped differently based on
     * the text next to it.
     *
     * <p>All text outside the range {@code contextStart..contextEnd} is ignored. The text between
     * {@code start} and {@code end} will be laid out and drawn.
     *
     * <p>The direction of the run is explicitly specified by {@code isRtl}. Thus, this method is
     * suitable only for runs of a single direction. Alignment of the text is as determined by the
     * Paint's TextAlign value. Further, {@code 0 <= contextStart <= start <= end <= contextEnd
     * <= text.length} must hold on entry.
     *
     * <p>Also see {@link android.graphics.Paint#getRunAdvance} for a corresponding method to
     * measure the text; the advance width of the text drawn matches the value obtained from that
     * method.
     *
     * @param text the text to render
     * @param start the start of the text to render. Data before this position
     *            can be used for shaping context.
     * @param end the end of the text to render. Data at or after this
     *            position can be used for shaping context.
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index of the end of the shaping context
     * @param x the x position at which to draw the text
     * @param y the y position at which to draw the text
     * @param isRtl whether the run is in RTL direction
     * @param paint the paint
     *
     * @see #drawTextRun(char[], int, int, int, int, float, float, boolean, Paint)
     */
    public void drawTextRun(@NonNull CharSequence text, int start, int end, int contextStart,
            int contextEnd, float x, float y, boolean isRtl, @NonNull Paint paint) {

        if (text == null) {
            throw new NullPointerException("text is null");
        }
        if (paint == null) {
            throw new NullPointerException("paint is null");
        }
        if ((start | end | contextStart | contextEnd | start - contextStart | end - start
                | contextEnd - end | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String || text instanceof SpannedString ||
                text instanceof SpannableString) {
            native_drawTextRun(mNativeCanvasWrapper, text.toString(), start, end, contextStart,
                    contextEnd, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
        } else if (text instanceof GraphicsOperations) {
            ((GraphicsOperations) text).drawTextRun(this, start, end,
                    contextStart, contextEnd, x, y, isRtl, paint);
        } else {
            int contextLen = contextEnd - contextStart;
            int len = end - start;
            char[] buf = TemporaryBuffer.obtain(contextLen);
            TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
            native_drawTextRun(mNativeCanvasWrapper, buf, start - contextStart, len,
                    0, contextLen, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
            TemporaryBuffer.recycle(buf);
        }
    }


Number 124:
API Relative Path:
src.android.graphics.Canvas.java-drawTextRun(char[]-int-int-int-int-float-float-boolean-Paint)
Corresponding Source:
/**
     * Draw a run of text, all in a single direction, with optional context for complex text
     * shaping.
     *
     * <p>The run of text includes the characters from {@code start} to {@code end} in the text. In
     * addition, the range {@code contextStart} to {@code contextEnd} is used as context for the
     * purpose of complex text shaping, such as Arabic text potentially shaped differently based on
     * the text next to it.
     *
     * <p>All text outside the range {@code contextStart..contextEnd} is ignored. The text between
     * {@code start} and {@code end} will be laid out and drawn.
     *
     * <p>The direction of the run is explicitly specified by {@code isRtl}. Thus, this method is
     * suitable only for runs of a single direction. Alignment of the text is as determined by the
     * Paint's TextAlign value. Further, {@code 0 <= contextStart <= start <= end <= contextEnd
     * <= text.length} must hold on entry.
     *
     * <p>Also see {@link android.graphics.Paint#getRunAdvance} for a corresponding method to
     * measure the text; the advance width of the text drawn matches the value obtained from that
     * method.
     *
     * @param text the text to render
     * @param start the start of the text to render. Data before this position
     *            can be used for shaping context.
     * @param end the end of the text to render. Data at or after this
     *            position can be used for shaping context.
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index of the end of the shaping context
     * @param x the x position at which to draw the text
     * @param y the y position at which to draw the text
     * @param isRtl whether the run is in RTL direction
     * @param paint the paint
     *
     * @see #drawTextRun(char[], int, int, int, int, float, float, boolean, Paint)
     */
    public void drawTextRun(@NonNull CharSequence text, int start, int end, int contextStart,
            int contextEnd, float x, float y, boolean isRtl, @NonNull Paint paint) {

        if (text == null) {
            throw new NullPointerException("text is null");
        }
        if (paint == null) {
            throw new NullPointerException("paint is null");
        }
        if ((start | end | contextStart | contextEnd | start - contextStart | end - start
                | contextEnd - end | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String || text instanceof SpannedString ||
                text instanceof SpannableString) {
            native_drawTextRun(mNativeCanvasWrapper, text.toString(), start, end, contextStart,
                    contextEnd, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
        } else if (text instanceof GraphicsOperations) {
            ((GraphicsOperations) text).drawTextRun(this, start, end,
                    contextStart, contextEnd, x, y, isRtl, paint);
        } else {
            int contextLen = contextEnd - contextStart;
            int len = end - start;
            char[] buf = TemporaryBuffer.obtain(contextLen);
            TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
            native_drawTextRun(mNativeCanvasWrapper, buf, start - contextStart, len,
                    0, contextLen, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
            TemporaryBuffer.recycle(buf);
        }
    }


Number 125:
API Relative Path:
src.android.graphics.Canvas.java-drawTextRun(char[]-int-int-int-int-float-float-boolean-Paint)
Corresponding Source:
/**
     * Draw a run of text, all in a single direction, with optional context for complex text
     * shaping.
     *
     * <p>The run of text includes the characters from {@code start} to {@code end} in the text. In
     * addition, the range {@code contextStart} to {@code contextEnd} is used as context for the
     * purpose of complex text shaping, such as Arabic text potentially shaped differently based on
     * the text next to it.
     *
     * <p>All text outside the range {@code contextStart..contextEnd} is ignored. The text between
     * {@code start} and {@code end} will be laid out and drawn.
     *
     * <p>The direction of the run is explicitly specified by {@code isRtl}. Thus, this method is
     * suitable only for runs of a single direction. Alignment of the text is as determined by the
     * Paint's TextAlign value. Further, {@code 0 <= contextStart <= start <= end <= contextEnd
     * <= text.length} must hold on entry.
     *
     * <p>Also see {@link android.graphics.Paint#getRunAdvance} for a corresponding method to
     * measure the text; the advance width of the text drawn matches the value obtained from that
     * method.
     *
     * @param text the text to render
     * @param start the start of the text to render. Data before this position
     *            can be used for shaping context.
     * @param end the end of the text to render. Data at or after this
     *            position can be used for shaping context.
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index of the end of the shaping context
     * @param x the x position at which to draw the text
     * @param y the y position at which to draw the text
     * @param isRtl whether the run is in RTL direction
     * @param paint the paint
     *
     * @see #drawTextRun(char[], int, int, int, int, float, float, boolean, Paint)
     */
    public void drawTextRun(@NonNull CharSequence text, int start, int end, int contextStart,
            int contextEnd, float x, float y, boolean isRtl, @NonNull Paint paint) {

        if (text == null) {
            throw new NullPointerException("text is null");
        }
        if (paint == null) {
            throw new NullPointerException("paint is null");
        }
        if ((start | end | contextStart | contextEnd | start - contextStart | end - start
                | contextEnd - end | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String || text instanceof SpannedString ||
                text instanceof SpannableString) {
            native_drawTextRun(mNativeCanvasWrapper, text.toString(), start, end, contextStart,
                    contextEnd, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
        } else if (text instanceof GraphicsOperations) {
            ((GraphicsOperations) text).drawTextRun(this, start, end,
                    contextStart, contextEnd, x, y, isRtl, paint);
        } else {
            int contextLen = contextEnd - contextStart;
            int len = end - start;
            char[] buf = TemporaryBuffer.obtain(contextLen);
            TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
            native_drawTextRun(mNativeCanvasWrapper, buf, start - contextStart, len,
                    0, contextLen, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
            TemporaryBuffer.recycle(buf);
        }
    }


Number 126:
API Relative Path:
src.android.graphics.Canvas.java-drawTextRun(char[]-int-int-int-int-float-float-boolean-Paint)
Corresponding Source:
/**
     * Draw a run of text, all in a single direction, with optional context for complex text
     * shaping.
     *
     * <p>The run of text includes the characters from {@code start} to {@code end} in the text. In
     * addition, the range {@code contextStart} to {@code contextEnd} is used as context for the
     * purpose of complex text shaping, such as Arabic text potentially shaped differently based on
     * the text next to it.
     *
     * <p>All text outside the range {@code contextStart..contextEnd} is ignored. The text between
     * {@code start} and {@code end} will be laid out and drawn.
     *
     * <p>The direction of the run is explicitly specified by {@code isRtl}. Thus, this method is
     * suitable only for runs of a single direction. Alignment of the text is as determined by the
     * Paint's TextAlign value. Further, {@code 0 <= contextStart <= start <= end <= contextEnd
     * <= text.length} must hold on entry.
     *
     * <p>Also see {@link android.graphics.Paint#getRunAdvance} for a corresponding method to
     * measure the text; the advance width of the text drawn matches the value obtained from that
     * method.
     *
     * @param text the text to render
     * @param start the start of the text to render. Data before this position
     *            can be used for shaping context.
     * @param end the end of the text to render. Data at or after this
     *            position can be used for shaping context.
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index of the end of the shaping context
     * @param x the x position at which to draw the text
     * @param y the y position at which to draw the text
     * @param isRtl whether the run is in RTL direction
     * @param paint the paint
     *
     * @see #drawTextRun(char[], int, int, int, int, float, float, boolean, Paint)
     */
    public void drawTextRun(@NonNull CharSequence text, int start, int end, int contextStart,
            int contextEnd, float x, float y, boolean isRtl, @NonNull Paint paint) {

        if (text == null) {
            throw new NullPointerException("text is null");
        }
        if (paint == null) {
            throw new NullPointerException("paint is null");
        }
        if ((start | end | contextStart | contextEnd | start - contextStart | end - start
                | contextEnd - end | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String || text instanceof SpannedString ||
                text instanceof SpannableString) {
            native_drawTextRun(mNativeCanvasWrapper, text.toString(), start, end, contextStart,
                    contextEnd, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
        } else if (text instanceof GraphicsOperations) {
            ((GraphicsOperations) text).drawTextRun(this, start, end,
                    contextStart, contextEnd, x, y, isRtl, paint);
        } else {
            int contextLen = contextEnd - contextStart;
            int len = end - start;
            char[] buf = TemporaryBuffer.obtain(contextLen);
            TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
            native_drawTextRun(mNativeCanvasWrapper, buf, start - contextStart, len,
                    0, contextLen, x, y, isRtl, paint.getNativeInstance(), paint.mNativeTypeface);
            TemporaryBuffer.recycle(buf);
        }
    }


Number 127:
API Relative Path:
src.android.graphics.Color.java-HSVToColor(int-float)
Corresponding Source:
private static native int nativeHSVToColor(int alpha, float hsv[]);


Number 128:
API Relative Path:
src.android.graphics.Color.java-RGBToHSV(int-int-int-float)
Corresponding Source:
private static native void nativeRGBToHSV(int red, int greed, int blue, float hsv[]);


Number 129:
API Relative Path:
src.android.graphics.ColorMatrixColorFilter.java-ColorMatrixColorFilter(float[])
Corresponding Source:
/**
     * Create a color filter that transforms colors through a 4x5 color matrix.
     *
     * @param array Array of floats used to transform colors, treated as a 4x5
     *              matrix. The first 20 entries of the array are copied into
     *              the filter. See ColorMatrix.
     */
    public ColorMatrixColorFilter(float[] array) {
        if (array.length < 20) {
            throw new ArrayIndexOutOfBoundsException();
        }
        mMatrix.set(array);
        update();
    }


Number 130:
API Relative Path:
src.android.graphics.ColorMatrixColorFilter.java-setColorMatrix(float[])
Corresponding Source:
/**
     * Specifies the color matrix used by this filter. If the specified
     * color matrix is null, this filter's color matrix will be reset to
     * the identity matrix.
     *
     * @param array Array of floats used to transform colors, treated as a 4x5
     *              matrix. The first 20 entries of the array are copied into
     *              the filter. See {@link ColorMatrix}.
     *
     * @see #getColorMatrix()
     * @see android.graphics.ColorMatrix#reset()
     * @see #setColorMatrix(ColorMatrix)
     *
     * @throws ArrayIndexOutOfBoundsException if the specified array's
     *         length is < 20
     *
     * @hide
     */
    public void setColorMatrix(float[] array) {
        if (array == null) {
            mMatrix.reset();
        } else {
            if (array.length < 20) {
                throw new ArrayIndexOutOfBoundsException();
            }

            mMatrix.set(array);
        }
        update();
    }


Number 131:
API Relative Path:
src.android.graphics.DashPathEffect.java-DashPathEffect(float-float)
Corresponding Source:
/**
     * The intervals array must contain an even number of entries (>=2), with
     * the even indices specifying the "on" intervals, and the odd indices
     * specifying the "off" intervals. phase is an offset into the intervals
     * array (mod the sum of all of the intervals). The intervals array
     * controls the length of the dashes. The paint's strokeWidth controls the
     * thickness of the dashes.
     * Note: this patheffect only affects drawing with the paint's style is set
     * to STROKE or FILL_AND_STROKE. It is ignored if the drawing is done with
     * style == FILL.
     * @param intervals array of ON and OFF distances
     * @param phase offset into the intervals array
     */
    public DashPathEffect(float intervals[], float phase) {
        if (intervals.length < 2) {
            throw new ArrayIndexOutOfBoundsException();
        }
        native_instance = nativeCreate(intervals, phase);
    }


Number 132:
API Relative Path:
src.android.graphics.drawable.AnimatedStateListDrawable.java-addState(int[]-Drawable-int)
Corresponding Source:
/**
     * Add a new drawable to the set of keyframes.
     *
     * @param stateSet An array of resource IDs to associate with the keyframe
     * @param drawable The drawable to show when in the specified state, may not be null
     * @param id The unique identifier for the keyframe
     */
    public void addState(@NonNull int[] stateSet, @NonNull Drawable drawable, int id) {
        if (drawable == null) {
            throw new IllegalArgumentException("Drawable must not be null");
        }

        mState.addStateSet(stateSet, drawable, id);
        onStateChange(getState());
    }


Number 133:
API Relative Path:
src.android.graphics.drawable.AnimatedStateListDrawable.java-addTransition(int-int-T-boolean)
Corresponding Source:
/**
     * Adds a new transition between keyframes.
     *
     * @param fromId Unique identifier of the starting keyframe
     * @param toId Unique identifier of the ending keyframe
     * @param transition An {@link Animatable} drawable to use as a transition, may not be null
     * @param reversible Whether the transition can be reversed
     */
    public <T extends Drawable & Animatable> void addTransition(int fromId, int toId,
            @NonNull T transition, boolean reversible) {
        if (transition == null) {
            throw new IllegalArgumentException("Transition drawable must not be null");
        }

        mState.addTransition(fromId, toId, transition, reversible);
    }


Number 134:
API Relative Path:
src.android.graphics.drawable.Drawable.java-createFromPath(String)
Corresponding Source:
/**
     * Create a drawable from file path name.
     */
    public static Drawable createFromPath(String pathName) {
        if (pathName == null) {
            return null;
        }

        Trace.traceBegin(Trace.TRACE_TAG_RESOURCES, pathName);
        try {
            Bitmap bm = BitmapFactory.decodeFile(pathName);
            if (bm != null) {
                return drawableFromBitmap(null, bm, null, null, null, pathName);
            }
        } finally {
            Trace.traceEnd(Trace.TRACE_TAG_RESOURCES);
        }

        return null;
    }


Number 135:
API Relative Path:
src.android.graphics.drawable.DrawableInflater.java-inflateFromXml(String-XmlPullParser-AttributeSet-Theme)
Corresponding Source:
/**
     * Inflates a drawable from inside an XML document using an optional
     * {@link Theme}.
     * <p>
     * This method should be called on a parser positioned at a tag in an XML
     * document defining a drawable resource. It will attempt to create a
     * Drawable from the tag at the current position.
     *
     * @param name the name of the tag at the current position
     * @param parser an XML parser positioned at the drawable tag
     * @param attrs an attribute set that wraps the parser
     * @param theme the theme against which the drawable should be inflated, or
     *              {@code null} to not inflate against a theme
     * @return a drawable
     *
     * @throws XmlPullParserException
     * @throws IOException
     */
    @NonNull
    public Drawable inflateFromXml(@NonNull String name, @NonNull XmlPullParser parser,
            @NonNull AttributeSet attrs, @Nullable Theme theme)
            throws XmlPullParserException, IOException {
        // Inner classes must be referenced as Outer$Inner, but XML tag names
        // can't contain $, so the <drawable> tag allows developers to specify
        // the class in an attribute. We'll still run it through inflateFromTag
        // to stay consistent with how LayoutInflater works.
        if (name.equals("drawable")) {
            name = attrs.getAttributeValue(null, "class");
            if (name == null) {
                throw new InflateException("<drawable> tag must specify class attribute");
            }
        }

        Drawable drawable = inflateFromTag(name);
        if (drawable == null) {
            drawable = inflateFromClass(name);
        }
        drawable.inflate(mRes, parser, attrs, theme);
        return drawable;
    }


Number 136:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithBitmap(Bitmap)
Corresponding Source:
/**
     * Create an Icon pointing to a bitmap in memory.
     * @param bits A valid {@link android.graphics.Bitmap} object
     */
    public static Icon createWithBitmap(Bitmap bits) {
        if (bits == null) {
            throw new IllegalArgumentException("Bitmap must not be null.");
        }
        final Icon rep = new Icon(TYPE_BITMAP);
        rep.setBitmap(bits);
        return rep;
    }


Number 137:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithContentUri(String)
Corresponding Source:
/**
     * Create an Icon pointing to an image file specified by URI.
     *
     * @param uri A uri referring to local content:// or file:// image data.
     */
    public static Icon createWithContentUri(String uri) {
        if (uri == null) {
            throw new IllegalArgumentException("Uri must not be null.");
        }
        final Icon rep = new Icon(TYPE_URI);
        rep.mString1 = uri;
        return rep;
    }


Number 138:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithContentUri(Uri)
Corresponding Source:
/**
     * Create an Icon pointing to an image file specified by URI.
     *
     * @param uri A uri referring to local content:// or file:// image data.
     */
    public static Icon createWithContentUri(Uri uri) {
        if (uri == null) {
            throw new IllegalArgumentException("Uri must not be null.");
        }
        final Icon rep = new Icon(TYPE_URI);
        rep.mString1 = uri.toString();
        return rep;
    }


Number 139:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithData(byte[]-int-int)
Corresponding Source:
/**
     * Create an Icon pointing to a compressed bitmap stored in a byte array.
     * @param data Byte array storing compressed bitmap data of a type that
     *             {@link android.graphics.BitmapFactory}
     *             can decode (see {@link android.graphics.Bitmap.CompressFormat}).
     * @param offset Offset into <code>data</code> at which the bitmap data starts
     * @param length Length of the bitmap data
     */
    public static Icon createWithData(byte[] data, int offset, int length) {
        if (data == null) {
            throw new IllegalArgumentException("Data must not be null.");
        }
        final Icon rep = new Icon(TYPE_DATA);
        rep.mObj1 = data;
        rep.mInt1 = length;
        rep.mInt2 = offset;
        return rep;
    }


Number 140:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithFilePath(String)
Corresponding Source:
/**
     * Create an Icon pointing to an image file specified by path.
     *
     * @param path A path to a file that contains compressed bitmap data of
     *           a type that {@link android.graphics.BitmapFactory} can decode.
     */
    public static Icon createWithFilePath(String path) {
        if (path == null) {
            throw new IllegalArgumentException("Path must not be null.");
        }
        final Icon rep = new Icon(TYPE_URI);
        rep.mString1 = path;
        return rep;
    }


Number 141:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithResource(Context-int)
Corresponding Source:
/**
     * Create an Icon pointing to a drawable resource.
     * @param context The context for the application whose resources should be used to resolve the
     *                given resource ID.
     * @param resId ID of the drawable resource
     */
    public static Icon createWithResource(Context context, @DrawableRes int resId) {
        if (context == null) {
            throw new IllegalArgumentException("Context must not be null.");
        }
        final Icon rep = new Icon(TYPE_RESOURCE);
        rep.mInt1 = resId;
        rep.mString1 = context.getPackageName();
        return rep;
    }


Number 142:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithResource(Resources-int)
Corresponding Source:
/**
     * Version of createWithResource that takes Resources. Do not use.
     * @hide
     */
    public static Icon createWithResource(Resources res, @DrawableRes int resId) {
        if (res == null) {
            throw new IllegalArgumentException("Resource must not be null.");
        }
        final Icon rep = new Icon(TYPE_RESOURCE);
        rep.mInt1 = resId;
        rep.mString1 = res.getResourcePackageName(resId);
        return rep;
    }


Number 143:
API Relative Path:
src.android.graphics.drawable.Icon.java-createWithResource(String-int)
Corresponding Source:
/**
     * Create an Icon pointing to a drawable resource.
     * @param resPackage Name of the package containing the resource in question
     * @param resId ID of the drawable resource
     */
    public static Icon createWithResource(String resPackage, @DrawableRes int resId) {
        if (resPackage == null) {
            throw new IllegalArgumentException("Resource package name must not be null.");
        }
        final Icon rep = new Icon(TYPE_RESOURCE);
        rep.mInt1 = resId;
        rep.mString1 = resPackage;
        return rep;
    }


Number 144:
API Relative Path:
src.android.graphics.drawable.LayerDrawable.java-getDrawable(int)
Corresponding Source:
/**
     * Returns the drawable for the layer at the specified index.
     *
     * @param index The index of the layer, must be in the range
     *              {@code 0...getNumberOfLayers()-1}.
     * @return The {@link Drawable} at the specified layer index.
     *
     * @see #setDrawable(int, Drawable)
     * @attr ref android.R.styleable#LayerDrawableItem_drawable
     */
    public Drawable getDrawable(int index) {
        if (index >= mLayerState.mNum) {
            throw new IndexOutOfBoundsException();
        }
        return mLayerState.mChildren[index].mDrawable;
    }


Number 145:
API Relative Path:
src.android.graphics.drawable.LayerDrawable.java-getId(int)
Corresponding Source:
/**
     * Returns the ID of the specified layer.
     *
     * @param index The index of the layer, must be in the range
     *              {@code 0...getNumberOfLayers()-1}.
     * @return The id of the layer or {@link android.view.View#NO_ID} if the
     *         layer has no id.
     *
     * @see #setId(int, int)
     * @attr ref android.R.styleable#LayerDrawableItem_id
     */
    public int getId(int index) {
        if (index >= mLayerState.mNum) {
            throw new IndexOutOfBoundsException();
        }
        return mLayerState.mChildren[index].mId;
    }


Number 146:
API Relative Path:
src.android.graphics.drawable.LayerDrawable.java-LayerDrawable(Drawable[]-LayerState)
Corresponding Source:
/**
     * Creates a new layer drawable with the specified list of layers and the
     * specified constant state.
     *
     * @param layers The list of layers to add to this drawable.
     * @param state The constant drawable state.
     */
    LayerDrawable(@NonNull Drawable[] layers, @Nullable LayerState state) {
        this(state, null);

        if (layers == null) {
            throw new IllegalArgumentException("layers must be non-null");
        }

        final int length = layers.length;
        final ChildDrawable[] r = new ChildDrawable[length];
        for (int i = 0; i < length; i++) {
            r[i] = new ChildDrawable(mLayerState.mDensity);
            r[i].mDrawable = layers[i];
            layers[i].setCallback(this);
            mLayerState.mChildrenChangingConfigurations |= layers[i].getChangingConfigurations();
        }
        mLayerState.mNum = length;
        mLayerState.mChildren = r;

        ensurePadding();
        refreshPadding();
    }


Number 147:
API Relative Path:
src.android.graphics.drawable.LayerDrawable.java-setDrawable(int-Drawable)
Corresponding Source:
/**
     * Sets the drawable for the layer at the specified index.
     *
     * @param index The index of the layer to modify, must be in the range
     *              {@code 0...getNumberOfLayers()-1}.
     * @param drawable The drawable to set for the layer.
     *
     * @see #getDrawable(int)
     * @attr ref android.R.styleable#LayerDrawableItem_drawable
     */
    public void setDrawable(int index, Drawable drawable) {
        if (index >= mLayerState.mNum) {
            throw new IndexOutOfBoundsException();
        }

        final ChildDrawable[] layers = mLayerState.mChildren;
        final ChildDrawable childDrawable = layers[index];
        if (childDrawable.mDrawable != null) {
            if (drawable != null) {
                final Rect bounds = childDrawable.mDrawable.getBounds();
                drawable.setBounds(bounds);
            }

            childDrawable.mDrawable.setCallback(null);
        }

        if (drawable != null) {
            drawable.setCallback(this);
        }

        childDrawable.mDrawable = drawable;
        mLayerState.invalidateCache();

        refreshChildPadding(index, childDrawable);
    }


Number 148:
API Relative Path:
src.android.graphics.drawable.RippleDrawable.java-RippleDrawable(ColorStateList-Drawable-Drawable)
Corresponding Source:
/**
     * Creates a new ripple drawable with the specified ripple color and
     * optional content and mask drawables.
     *
     * @param color The ripple color
     * @param content The content drawable, may be {@code null}
     * @param mask The mask drawable, may be {@code null}
     */
    public RippleDrawable(@NonNull ColorStateList color, @Nullable Drawable content,
            @Nullable Drawable mask) {
        this(new RippleState(null, null, null), null);

        if (color == null) {
            throw new IllegalArgumentException("RippleDrawable requires a non-null color");
        }

        if (content != null) {
            addLayer(content, null, 0, 0, 0, 0, 0);
        }

        if (mask != null) {
            addLayer(mask, null, android.R.id.mask, 0, 0, 0, 0);
        }

        setColor(color);
        ensurePadding();
        refreshPadding();
        updateLocalState();
    }


Number 149:
API Relative Path:
src.android.graphics.drawable.shapes.RoundRectShape.java-RoundRectShape(float[]-RectF-float[])
Corresponding Source:
/**
     * RoundRectShape constructor.
     * Specifies an outer (round)rect and an optional inner (round)rect.
     *
     * @param outerRadii An array of 8 radius values, for the outer roundrect. 
     *                   The first two floats are for the 
     *                   top-left corner (remaining pairs correspond clockwise). 
     *                   For no rounded corners on the outer rectangle, 
     *                   pass null.
     * @param inset      A RectF that specifies the distance from the inner 
     *                   rect to each side of the outer rect. 
     *                   For no inner, pass null.
     * @param innerRadii An array of 8 radius values, for the inner roundrect.
     *                   The first two floats are for the 
     *                   top-left corner (remaining pairs correspond clockwise). 
     *                   For no rounded corners on the inner rectangle, 
     *                   pass null.
     *                   If inset parameter is null, this parameter is ignored. 
     */
    public RoundRectShape(float[] outerRadii, RectF inset,
                          float[] innerRadii) {
        if (outerRadii != null && outerRadii.length < 8) {
            throw new ArrayIndexOutOfBoundsException("outer radii must have >= 8 values");
        }
        if (innerRadii != null && innerRadii.length < 8) {
            throw new ArrayIndexOutOfBoundsException("inner radii must have >= 8 values");
        }
        mOuterRadii = outerRadii;
        mInset = inset;
        mInnerRadii = innerRadii;
        
        if (inset != null) {
            mInnerRect = new RectF();
        }
        mPath = new Path();
    }


Number 150:
API Relative Path:
src.android.graphics.drawable.shapes.RoundRectShape.java-RoundRectShape(float[]-RectF-float[])
Corresponding Source:
/**
     * RoundRectShape constructor.
     * Specifies an outer (round)rect and an optional inner (round)rect.
     *
     * @param outerRadii An array of 8 radius values, for the outer roundrect. 
     *                   The first two floats are for the 
     *                   top-left corner (remaining pairs correspond clockwise). 
     *                   For no rounded corners on the outer rectangle, 
     *                   pass null.
     * @param inset      A RectF that specifies the distance from the inner 
     *                   rect to each side of the outer rect. 
     *                   For no inner, pass null.
     * @param innerRadii An array of 8 radius values, for the inner roundrect.
     *                   The first two floats are for the 
     *                   top-left corner (remaining pairs correspond clockwise). 
     *                   For no rounded corners on the inner rectangle, 
     *                   pass null.
     *                   If inset parameter is null, this parameter is ignored. 
     */
    public RoundRectShape(float[] outerRadii, RectF inset,
                          float[] innerRadii) {
        if (outerRadii != null && outerRadii.length < 8) {
            throw new ArrayIndexOutOfBoundsException("outer radii must have >= 8 values");
        }
        if (innerRadii != null && innerRadii.length < 8) {
            throw new ArrayIndexOutOfBoundsException("inner radii must have >= 8 values");
        }
        mOuterRadii = outerRadii;
        mInset = inset;
        mInnerRadii = innerRadii;
        
        if (inset != null) {
            mInnerRect = new RectF();
        }
        mPath = new Path();
    }


Number 151:
API Relative Path:
src.android.graphics.drawable.StateListDrawable.java-addState(int[]-Drawable)
Corresponding Source:
/**
     * Add a new image/string ID to the set of images.
     *
     * @param stateSet - An array of resource Ids to associate with the image.
     *                 Switch to this image by calling setState().
     * @param drawable -The image to show.
     */
    public void addState(int[] stateSet, Drawable drawable) {
        if (drawable != null) {
            mStateListState.addStateSet(stateSet, drawable);
            // in case the new state matches our current state...
            onStateChange(getState());
        }
    }


Number 152:
API Relative Path:
src.android.graphics.drawable.StateListDrawable.java-StateListDrawable(StateListState)
Corresponding Source:
/**
     * This constructor exists so subclasses can avoid calling the default
     * constructor and setting up a StateListDrawable-specific constant state.
     */
    StateListDrawable(@Nullable StateListState state) {
        if (state != null) {
            setConstantState(state);
        }
    }


Number 153:
API Relative Path:
src.android.graphics.EmbossMaskFilter.java-EmbossMaskFilter(float[]-float-float-float)
Corresponding Source:
/**
     * Create an emboss maskfilter
     *
     * @param direction  array of 3 scalars [x, y, z] specifying the direction of the light source
     * @param ambient    0...1 amount of ambient light
     * @param specular   coefficient for specular highlights (e.g. 8)
     * @param blurRadius amount to blur before applying lighting (e.g. 3)
     * @return           the emboss maskfilter
     */
    public EmbossMaskFilter(float[] direction, float ambient, float specular, float blurRadius) {
        if (direction.length < 3) {
            throw new ArrayIndexOutOfBoundsException();
        }
        native_instance = nativeConstructor(direction, ambient, specular, blurRadius);
    }


Number 154:
API Relative Path:
src.android.graphics.Interpolator.java-setKeyFrame(int-int-float[]-float[])
Corresponding Source:
/**
     * Assign the keyFrame (specified by index) a time value and an array of key
     * values and blend array.
     * 
     * @param index The index of the key frame to assign
     * @param msec The time (in mililiseconds) for this key frame. Based on the
     *        SystemClock.uptimeMillis() clock
     * @param values Array of values associated with theis key frame
     * @param blend (may be null) Optional array of 4 blend values
     */
    public void setKeyFrame(int index, int msec, float[] values, float[] blend) {
        if (index < 0 || index >= mFrameCount) {
            throw new IndexOutOfBoundsException();
        }
        if (values.length < mValueCount) {
            throw new ArrayStoreException();
        }
        if (blend != null && blend.length < 4) {
            throw new ArrayStoreException();
        }
        nativeSetKeyFrame(native_instance, index, msec, values, blend);
    }


Number 155:
API Relative Path:
src.android.graphics.Interpolator.java-setKeyFrame(int-int-float[]-float[])
Corresponding Source:
/**
     * Assign the keyFrame (specified by index) a time value and an array of key
     * values and blend array.
     * 
     * @param index The index of the key frame to assign
     * @param msec The time (in mililiseconds) for this key frame. Based on the
     *        SystemClock.uptimeMillis() clock
     * @param values Array of values associated with theis key frame
     * @param blend (may be null) Optional array of 4 blend values
     */
    public void setKeyFrame(int index, int msec, float[] values, float[] blend) {
        if (index < 0 || index >= mFrameCount) {
            throw new IndexOutOfBoundsException();
        }
        if (values.length < mValueCount) {
            throw new ArrayStoreException();
        }
        if (blend != null && blend.length < 4) {
            throw new ArrayStoreException();
        }
        nativeSetKeyFrame(native_instance, index, msec, values, blend);
    }


Number 156:
API Relative Path:
src.android.graphics.Interpolator.java-timeToValues(int-float[])
Corresponding Source:
/**
     * Given a millisecond time value (msec), return the interpolated values and
     * return whether the specified time was within the range of key times
     * (NORMAL), was before the first key time (FREEZE_START) or after the last
     * key time (FREEZE_END). In any event, computed values are always returned.
     * 
     * @param msec The time (in milliseconds) used to sample into the
     *        Interpolator. Based on the SystemClock.uptimeMillis() clock
     * @param values Where to write the computed values (may be NULL).
     * @return how the values were computed (even if values == null)
     */
    public Result timeToValues(int msec, float[] values) {
        if (values != null && values.length < mValueCount) {
            throw new ArrayStoreException();
        }
        switch (nativeTimeToValues(native_instance, msec, values)) {
            case 0: return Result.NORMAL;
            case 1: return Result.FREEZE_START;
            default: return Result.FREEZE_END;
        }
    }


Number 157:
API Relative Path:
src.android.graphics.LinearGradient.java-LinearGradient(float-float-float-float-int-float-TileMode)
Corresponding Source:
/** Create a shader that draws a linear gradient along a line.
        @param x0           The x-coordinate for the start of the gradient line
        @param y0           The y-coordinate for the start of the gradient line
        @param x1           The x-coordinate for the end of the gradient line
        @param y1           The y-coordinate for the end of the gradient line
        @param  colors      The colors to be distributed along the gradient line
        @param  positions   May be null. The relative positions [0..1] of
                            each corresponding color in the colors array. If this is null,
                            the the colors are distributed evenly along the gradient line.
        @param  tile        The Shader tiling mode
    */
    public LinearGradient(float x0, float y0, float x1, float y1, int colors[], float positions[],
            TileMode tile) {
        if (colors.length < 2) {
            throw new IllegalArgumentException("needs >= 2 number of colors");
        }
        if (positions != null && colors.length != positions.length) {
            throw new IllegalArgumentException("color and position arrays must be of equal length");
        }
        mType = TYPE_COLORS_AND_POSITIONS;
        mX0 = x0;
        mY0 = y0;
        mX1 = x1;
        mY1 = y1;
        mColors = colors;
        mPositions = positions;
        mTileMode = tile;
        init(nativeCreate1(x0, y0, x1, y1, colors, positions, tile.nativeInt));
    }


Number 158:
API Relative Path:
src.android.graphics.Matrix.java-getValues(float[])
Corresponding Source:
/** Copy 9 values from the matrix into the array.
    */
    public void getValues(float[] values) {
        if (values.length < 9) {
            throw new ArrayIndexOutOfBoundsException();
        }
        native_getValues(native_instance, values);
    }


Number 159:
API Relative Path:
src.android.graphics.Matrix.java-mapPoints(float[]-float[])
Corresponding Source:
/**
     * Apply this matrix to the array of 2D points specified by src, and write
     * the transformed points into the array of points specified by dst. The
     * two arrays represent their "points" as pairs of floats [x, y].
     *
     * @param dst   The array of dst points (x,y pairs)
     * @param src   The array of src points (x,y pairs)
     */
    public void mapPoints(float[] dst, float[] src) {
        if (dst.length != src.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        mapPoints(dst, 0, src, 0, dst.length >> 1);
    }


Number 160:
API Relative Path:
src.android.graphics.Matrix.java-mapRect(RectF-RectF)
Corresponding Source:
/**
     * Apply this matrix to the src rectangle, and write the transformed
     * rectangle into dst. This is accomplished by transforming the 4 corners of
     * src, and then setting dst to the bounds of those points.
     *
     * @param dst Where the transformed rectangle is written.
     * @param src The original rectangle to be transformed.
     * @return the result of calling rectStaysRect()
     */
    public boolean mapRect(RectF dst, RectF src) {
        if (dst == null || src == null) {
            throw new NullPointerException();
        }
        return native_mapRect(native_instance, dst, src);
    }


Number 161:
API Relative Path:
src.android.graphics.Matrix.java-mapVectors(float[]-float[])
Corresponding Source:
/**
     * Apply this matrix to the array of 2D vectors specified by src, and write
     * the transformed vectors into the array of vectors specified by dst. The
     * two arrays represent their "vectors" as pairs of floats [x, y].
     *
     * Note: this method does not apply the translation associated with the matrix. Use
     * {@link Matrix#mapPoints(float[], float[])} if you want the translation to be applied.
     *
     * @param dst   The array of dst vectors (x,y pairs)
     * @param src   The array of src vectors (x,y pairs)
     */
    public void mapVectors(float[] dst, float[] src) {
        if (dst.length != src.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        mapVectors(dst, 0, src, 0, dst.length >> 1);
    }


Number 162:
API Relative Path:
src.android.graphics.Matrix.java-setPolyToPoly(float[]-int-float[]-int-int)
Corresponding Source:
/**
     * Set the matrix such that the specified src points would map to the
     * specified dst points. The "points" are represented as an array of floats,
     * order [x0, y0, x1, y1, ...], where each "point" is 2 float values.
     *
     * @param src   The array of src [x,y] pairs (points)
     * @param srcIndex Index of the first pair of src values
     * @param dst   The array of dst [x,y] pairs (points)
     * @param dstIndex Index of the first pair of dst values
     * @param pointCount The number of pairs/points to be used. Must be [0..4]
     * @return true if the matrix was set to the specified transformation
     */
    public boolean setPolyToPoly(float[] src, int srcIndex,
                                 float[] dst, int dstIndex,
                                 int pointCount) {
        if (pointCount > 4) {
            throw new IllegalArgumentException();
        }
        checkPointArrays(src, srcIndex, dst, dstIndex, pointCount);
        return native_setPolyToPoly(native_instance, src, srcIndex,
                                    dst, dstIndex, pointCount);
    }


Number 163:
API Relative Path:
src.android.graphics.Matrix.java-setRectToRect(RectF-RectF-ScaleToFit)
Corresponding Source:
/**
     * Set the matrix to the scale and translate values that map the source
     * rectangle to the destination rectangle, returning true if the the result
     * can be represented.
     *
     * @param src the source rectangle to map from.
     * @param dst the destination rectangle to map to.
     * @param stf the ScaleToFit option
     * @return true if the matrix can be represented by the rectangle mapping.
     */
    public boolean setRectToRect(RectF src, RectF dst, ScaleToFit stf) {
        if (dst == null || src == null) {
            throw new NullPointerException();
        }
        return native_setRectToRect(native_instance, src, dst, stf.nativeInt);
    }


Number 164:
API Relative Path:
src.android.graphics.Matrix.java-setValues(float[])
Corresponding Source:
/** Copy 9 values from the array into the matrix.
        Depending on the implementation of Matrix, these may be
        transformed into 16.16 integers in the Matrix, such that
        a subsequent call to getValues() will not yield exactly
        the same values.
    */
    public void setValues(float[] values) {
        if (values.length < 9) {
            throw new ArrayIndexOutOfBoundsException();
        }
        native_setValues(native_instance, values);
    }


Number 165:
API Relative Path:
src.android.graphics.Paint.java-breakText(char[]-int-int-float-float[])
Corresponding Source:
/**
     * Measure the text, stopping early if the measured width exceeds maxWidth.
     * Return the number of chars that were measured, and if measuredWidth is
     * not null, return in it the actual width measured.
     *
     * @param text  The text to measure. Cannot be null.
     * @param index The offset into text to begin measuring at
     * @param count The number of maximum number of entries to measure. If count
     *              is negative, then the characters are measured in reverse order.
     * @param maxWidth The maximum width to accumulate.
     * @param measuredWidth Optional. If not null, returns the actual width
     *                     measured.
     * @return The number of chars that were measured. Will always be <=
     *         abs(count).
     */
    public int breakText(char[] text, int index, int count,
                                float maxWidth, float[] measuredWidth) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if (index < 0 || text.length - index < Math.abs(count)) {
            throw new ArrayIndexOutOfBoundsException();
        }

        if (text.length == 0 || count == 0) {
            return 0;
        }
        if (!mHasCompatScaling) {
            return nBreakText(mNativePaint, mNativeTypeface, text, index, count, maxWidth,
                    mBidiFlags, measuredWidth);
        }

        final float oldSize = getTextSize();
        setTextSize(oldSize * mCompatScaling);
        int res = nBreakText(mNativePaint, mNativeTypeface, text, index, count,
                maxWidth * mCompatScaling, mBidiFlags, measuredWidth);
        setTextSize(oldSize);
        if (measuredWidth != null) measuredWidth[0] *= mInvCompatScaling;
        return res;
    }


Number 166:
API Relative Path:
src.android.graphics.Paint.java-getOffsetForAdvance(char[]-int-int-int-int-boolean-float)
Corresponding Source:
/**
     * @see #getOffsetForAdvance(char[], int, int, int, int, boolean, float)
     *
     * @param text the text to measure. Cannot be null.
     * @param start the index of the start of the range to measure
     * @param end the index + 1 of the end of the range to measure
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index + 1 of the end of the range to measure
     * @param isRtl whether the run is in RTL direction
     * @param advance width relative to start of run
     * @return index of offset
     */
    public int getOffsetForAdvance(CharSequence text, int start, int end, int contextStart,
            int contextEnd, boolean isRtl, float advance) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((contextStart | start | end | contextEnd
                | start - contextStart | end - start | contextEnd - end
                | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }
        // TODO performance: specialized alternatives to avoid buffer copy, if win is significant
        char[] buf = TemporaryBuffer.obtain(contextEnd - contextStart);
        TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
        int result = getOffsetForAdvance(buf, start - contextStart, end - contextStart, 0,
                contextEnd - contextStart, isRtl, advance) + contextStart;
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 167:
API Relative Path:
src.android.graphics.Paint.java-getRunAdvance(char[]-int-int-int-int-boolean-int)
Corresponding Source:
/**
     * @see #getRunAdvance(char[], int, int, int, int, boolean, int)
     *
     * @param text the text to measure. Cannot be null.
     * @param start the index of the start of the range to measure
     * @param end the index + 1 of the end of the range to measure
     * @param contextStart the index of the start of the shaping context
     * @param contextEnd the index + 1 of the end of the shaping context
     * @param isRtl whether the run is in RTL direction
     * @param offset index of caret position
     * @return width measurement between start and offset
     */
    public float getRunAdvance(CharSequence text, int start, int end, int contextStart,
            int contextEnd, boolean isRtl, int offset) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((contextStart | start | offset | end | contextEnd
                | start - contextStart | offset - start | end - offset
                | contextEnd - end | text.length() - contextEnd) < 0) {
            throw new IndexOutOfBoundsException();
        }
        if (end == start) {
            return 0.0f;
        }
        // TODO performance: specialized alternatives to avoid buffer copy, if win is significant
        char[] buf = TemporaryBuffer.obtain(contextEnd - contextStart);
        TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
        float result = getRunAdvance(buf, start - contextStart, end - contextStart, 0,
                contextEnd - contextStart, isRtl, offset - contextStart);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 168:
API Relative Path:
src.android.graphics.Paint.java-getTextBounds(char[]-int-int-Rect)
Corresponding Source:
/**
     * Return in bounds (allocated by the caller) the smallest rectangle that
     * encloses all of the characters, with an implied origin at (0,0).
     *
     * @param text  Array of chars to measure and return their unioned bounds
     * @param index Index of the first char in the array to measure
     * @param count The number of chars, beginning at index, to measure
     * @param bounds Returns the unioned bounds of all the text. Must be
     *               allocated by the caller.
     */
    public void getTextBounds(char[] text, int index, int count, Rect bounds) {
        if ((index | count) < 0 || index + count > text.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        if (bounds == null) {
            throw new NullPointerException("need bounds Rect");
        }
        nGetCharArrayBounds(mNativePaint, mNativeTypeface, text, index, count, mBidiFlags,
            bounds);
    }


Number 169:
API Relative Path:
src.android.graphics.Paint.java-getTextBounds(char[]-int-int-Rect)
Corresponding Source:
/**
     * Return in bounds (allocated by the caller) the smallest rectangle that
     * encloses all of the characters, with an implied origin at (0,0).
     *
     * @param text  Array of chars to measure and return their unioned bounds
     * @param index Index of the first char in the array to measure
     * @param count The number of chars, beginning at index, to measure
     * @param bounds Returns the unioned bounds of all the text. Must be
     *               allocated by the caller.
     */
    public void getTextBounds(char[] text, int index, int count, Rect bounds) {
        if ((index | count) < 0 || index + count > text.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        if (bounds == null) {
            throw new NullPointerException("need bounds Rect");
        }
        nGetCharArrayBounds(mNativePaint, mNativeTypeface, text, index, count, mBidiFlags,
            bounds);
    }


Number 170:
API Relative Path:
src.android.graphics.Paint.java-getTextBounds(String-int-int-Rect)
Corresponding Source:
/**
     * Return in bounds (allocated by the caller) the smallest rectangle that
     * encloses all of the characters, with an implied origin at (0,0).
     *
     * @param text  String to measure and return its bounds
     * @param start Index of the first char in the string to measure
     * @param end   1 past the last char in the string measure
     * @param bounds Returns the unioned bounds of all the text. Must be
     *               allocated by the caller.
     */
    public void getTextBounds(String text, int start, int end, Rect bounds) {
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }
        if (bounds == null) {
            throw new NullPointerException("need bounds Rect");
        }
        nGetStringBounds(mNativePaint, mNativeTypeface, text, start, end, mBidiFlags, bounds);
    }


Number 171:
API Relative Path:
src.android.graphics.Paint.java-getTextPath(char[]-int-int-float-float-Path)
Corresponding Source:
/**
     * Return the path (outline) for the specified text.
     * Note: just like Canvas.drawText, this will respect the Align setting in
     * the paint.
     *
     * @param text     The text to retrieve the path from
     * @param index    The index of the first character in text
     * @param count    The number of characterss starting with index
     * @param x        The x coordinate of the text's origin
     * @param y        The y coordinate of the text's origin
     * @param path     The path to receive the data describing the text. Must
     *                 be allocated by the caller.
     */
    public void getTextPath(char[] text, int index, int count,
                            float x, float y, Path path) {
        if ((index | count) < 0 || index + count > text.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        nGetTextPath(mNativePaint, mNativeTypeface, mBidiFlags, text, index, count, x, y,
                path.ni());
    }


Number 172:
API Relative Path:
src.android.graphics.Paint.java-getTextRunAdvances(CharSequence-int-int-int-int-boolean-float[]-int)
Corresponding Source:
/**
     * Convenience overload that takes a CharSequence instead of a
     * String.
     *
     * @see #getTextRunAdvances(String, int, int, int, int, boolean, float[], int)
     * @hide
     */
    public float getTextRunAdvances(CharSequence text, int start, int end,
            int contextStart, int contextEnd, boolean isRtl, float[] advances,
            int advancesIndex) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | contextStart | contextEnd | advancesIndex | (end - start)
                | (start - contextStart) | (contextEnd - end)
                | (text.length() - contextEnd)
                | (advances == null ? 0 :
                    (advances.length - advancesIndex - (end - start)))) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String) {
            return getTextRunAdvances((String) text, start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return getTextRunAdvances(text.toString(), start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations) text).getTextRunAdvances(start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex, this);
        }
        if (text.length() == 0 || end == start) {
            return 0f;
        }

        int contextLen = contextEnd - contextStart;
        int len = end - start;
        char[] buf = TemporaryBuffer.obtain(contextLen);
        TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
        float result = getTextRunAdvances(buf, start - contextStart, len,
                0, contextLen, isRtl, advances, advancesIndex);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 173:
API Relative Path:
src.android.graphics.Paint.java-getTextRunAdvances(char[]-int-int-int-int-boolean-float[]-int)
Corresponding Source:
/**
     * Convenience overload that takes a CharSequence instead of a
     * String.
     *
     * @see #getTextRunAdvances(String, int, int, int, int, boolean, float[], int)
     * @hide
     */
    public float getTextRunAdvances(CharSequence text, int start, int end,
            int contextStart, int contextEnd, boolean isRtl, float[] advances,
            int advancesIndex) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | contextStart | contextEnd | advancesIndex | (end - start)
                | (start - contextStart) | (contextEnd - end)
                | (text.length() - contextEnd)
                | (advances == null ? 0 :
                    (advances.length - advancesIndex - (end - start)))) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String) {
            return getTextRunAdvances((String) text, start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return getTextRunAdvances(text.toString(), start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations) text).getTextRunAdvances(start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex, this);
        }
        if (text.length() == 0 || end == start) {
            return 0f;
        }

        int contextLen = contextEnd - contextStart;
        int len = end - start;
        char[] buf = TemporaryBuffer.obtain(contextLen);
        TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
        float result = getTextRunAdvances(buf, start - contextStart, len,
                0, contextLen, isRtl, advances, advancesIndex);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 174:
API Relative Path:
src.android.graphics.Paint.java-getTextRunAdvances(char[]-int-int-int-int-boolean-float[]-int)
Corresponding Source:
/**
     * Convenience overload that takes a CharSequence instead of a
     * String.
     *
     * @see #getTextRunAdvances(String, int, int, int, int, boolean, float[], int)
     * @hide
     */
    public float getTextRunAdvances(CharSequence text, int start, int end,
            int contextStart, int contextEnd, boolean isRtl, float[] advances,
            int advancesIndex) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | contextStart | contextEnd | advancesIndex | (end - start)
                | (start - contextStart) | (contextEnd - end)
                | (text.length() - contextEnd)
                | (advances == null ? 0 :
                    (advances.length - advancesIndex - (end - start)))) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text instanceof String) {
            return getTextRunAdvances((String) text, start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return getTextRunAdvances(text.toString(), start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations) text).getTextRunAdvances(start, end,
                    contextStart, contextEnd, isRtl, advances, advancesIndex, this);
        }
        if (text.length() == 0 || end == start) {
            return 0f;
        }

        int contextLen = contextEnd - contextStart;
        int len = end - start;
        char[] buf = TemporaryBuffer.obtain(contextLen);
        TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
        float result = getTextRunAdvances(buf, start - contextStart, len,
                0, contextLen, isRtl, advances, advancesIndex);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 175:
API Relative Path:
src.android.graphics.Paint.java-getTextRunCursor(char[]-int-int-int-int-int)
Corresponding Source:
/**
     * Returns the next cursor position in the run.  This avoids placing the
     * cursor between surrogates, between characters that form conjuncts,
     * between base characters and combining marks, or within a reordering
     * cluster.
     *
     * <p>ContextStart, contextEnd, and offset are relative to the start of
     * text.  The context is the shaping context for cursor movement, generally
     * the bounds of the metric span enclosing the cursor in the direction of
     * movement.
     *
     * <p>If cursorOpt is {@link #CURSOR_AT} and the offset is not a valid
     * cursor position, this returns -1.  Otherwise this will never return a
     * value before contextStart or after contextEnd.
     *
     * @param text the text
     * @param contextStart the start of the context
     * @param contextEnd the end of the context
     * @param dir either {@link #DIRECTION_RTL} or {@link #DIRECTION_LTR}
     * @param offset the cursor position to move from
     * @param cursorOpt how to move the cursor, one of {@link #CURSOR_AFTER},
     * {@link #CURSOR_AT_OR_AFTER}, {@link #CURSOR_BEFORE},
     * {@link #CURSOR_AT_OR_BEFORE}, or {@link #CURSOR_AT}
     * @return the offset of the next position, or -1
     * @hide
     */
    public int getTextRunCursor(CharSequence text, int contextStart,
           int contextEnd, int dir, int offset, int cursorOpt) {

        if (text instanceof String || text instanceof SpannedString ||
                text instanceof SpannableString) {
            return getTextRunCursor(text.toString(), contextStart, contextEnd,
                    dir, offset, cursorOpt);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations) text).getTextRunCursor(
                    contextStart, contextEnd, dir, offset, cursorOpt, this);
        }

        int contextLen = contextEnd - contextStart;
        char[] buf = TemporaryBuffer.obtain(contextLen);
        TextUtils.getChars(text, contextStart, contextEnd, buf, 0);
        int relPos = getTextRunCursor(buf, 0, contextLen, dir, offset - contextStart, cursorOpt);
        TemporaryBuffer.recycle(buf);
        return (relPos == -1) ? -1 : relPos + contextStart;
    }


Number 176:
API Relative Path:
src.android.graphics.Paint.java-getTextRunCursor(String-int-int-int-int-int)
Corresponding Source:
/**
     * Returns the next cursor position in the run.  This avoids placing the
     * cursor between surrogates, between characters that form conjuncts,
     * between base characters and combining marks, or within a reordering
     * cluster.
     *
     * <p>ContextStart, contextEnd, and offset are relative to the start of
     * text.  The context is the shaping context for cursor movement, generally
     * the bounds of the metric span enclosing the cursor in the direction of
     * movement.
     *
     * <p>If cursorOpt is {@link #CURSOR_AT} and the offset is not a valid
     * cursor position, this returns -1.  Otherwise this will never return a
     * value before contextStart or after contextEnd.
     *
     * @param text the text
     * @param contextStart the start of the context
     * @param contextEnd the end of the context
     * @param dir either {@link #DIRECTION_RTL} or {@link #DIRECTION_LTR}
     * @param offset the cursor position to move from
     * @param cursorOpt how to move the cursor, one of {@link #CURSOR_AFTER},
     * {@link #CURSOR_AT_OR_AFTER}, {@link #CURSOR_BEFORE},
     * {@link #CURSOR_AT_OR_BEFORE}, or {@link #CURSOR_AT}
     * @return the offset of the next position, or -1
     * @hide
     */
    public int getTextRunCursor(String text, int contextStart, int contextEnd,
            int dir, int offset, int cursorOpt) {
        if (((contextStart | contextEnd | offset | (contextEnd - contextStart)
                | (offset - contextStart) | (contextEnd - offset)
                | (text.length() - contextEnd) | cursorOpt) < 0)
                || cursorOpt > CURSOR_OPT_MAX_VALUE) {
            throw new IndexOutOfBoundsException();
        }

        return nGetTextRunCursor(mNativePaint, text,
                contextStart, contextEnd, dir, offset, cursorOpt);
    }


Number 177:
API Relative Path:
src.android.graphics.Paint.java-getTextWidths(CharSequence-int-int-float[])
Corresponding Source:
/**
     * Return the advance widths for the characters in the string.
     *
     * @param text     The text to measure. Cannot be null.
     * @param start    The index of the first char to to measure
     * @param end      The end of the text slice to measure
     * @param widths   array to receive the advance widths of the characters.
     *                 Must be at least a large as (end - start).
     * @return         the actual number of widths returned.
     */
    public int getTextWidths(CharSequence text, int start, int end,
                             float[] widths) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }
        if (end - start > widths.length) {
            throw new ArrayIndexOutOfBoundsException();
        }

        if (text.length() == 0 || start == end) {
            return 0;
        }
        if (text instanceof String) {
            return getTextWidths((String) text, start, end, widths);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return getTextWidths(text.toString(), start, end, widths);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations) text).getTextWidths(start, end,
                                                                 widths, this);
        }

        char[] buf = TemporaryBuffer.obtain(end - start);
        TextUtils.getChars(text, start, end, buf, 0);
        int result = getTextWidths(buf, 0, end - start, widths);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 178:
API Relative Path:
src.android.graphics.Paint.java-getTextWidths(char[]-int-int-float[])
Corresponding Source:
/**
     * Return the advance widths for the characters in the string.
     *
     * @param text     The text to measure. Cannot be null.
     * @param start    The index of the first char to to measure
     * @param end      The end of the text slice to measure
     * @param widths   array to receive the advance widths of the characters.
     *                 Must be at least a large as (end - start).
     * @return         the actual number of widths returned.
     */
    public int getTextWidths(CharSequence text, int start, int end,
                             float[] widths) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }
        if (end - start > widths.length) {
            throw new ArrayIndexOutOfBoundsException();
        }

        if (text.length() == 0 || start == end) {
            return 0;
        }
        if (text instanceof String) {
            return getTextWidths((String) text, start, end, widths);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return getTextWidths(text.toString(), start, end, widths);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations) text).getTextWidths(start, end,
                                                                 widths, this);
        }

        char[] buf = TemporaryBuffer.obtain(end - start);
        TextUtils.getChars(text, start, end, buf, 0);
        int result = getTextWidths(buf, 0, end - start, widths);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 179:
API Relative Path:
src.android.graphics.Paint.java-getTextWidths(String-int-int-float[])
Corresponding Source:
/**
     * Return the advance widths for the characters in the string.
     *
     * @param text   The text to measure. Cannot be null.
     * @param start  The index of the first char to to measure
     * @param end    The end of the text slice to measure
     * @param widths array to receive the advance widths of the characters.
     *               Must be at least a large as the text.
     * @return       the number of code units in the specified text.
     */
    public int getTextWidths(String text, int start, int end, float[] widths) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }
        if (end - start > widths.length) {
            throw new ArrayIndexOutOfBoundsException();
        }

        if (text.length() == 0 || start == end) {
            return 0;
        }
        if (!mHasCompatScaling) {
            nGetTextAdvances(mNativePaint, mNativeTypeface, text, start, end, start, end,
                    mBidiFlags, widths, 0);
            return end - start;
        }

        final float oldSize = getTextSize();
        setTextSize(oldSize * mCompatScaling);
        nGetTextAdvances(mNativePaint, mNativeTypeface, text, start, end, start, end,
                mBidiFlags, widths, 0);
        setTextSize(oldSize);
        for (int i = 0; i < end - start; i++) {
            widths[i] *= mInvCompatScaling;
        }
        return end - start;
    }


Number 180:
API Relative Path:
src.android.graphics.Paint.java-measureText(CharSequence-int-int)
Corresponding Source:
/**
     * Return the width of the text.
     *
     * @param text  The text to measure
     * @param start The index of the first character to start measuring
     * @param end   1 beyond the index of the last character to measure
     * @return      The width of the text
     */
    public float measureText(CharSequence text, int start, int end) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text.length() == 0 || start == end) {
            return 0f;
        }
        if (text instanceof String) {
            return measureText((String)text, start, end);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return measureText(text.toString(), start, end);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations)text).measureText(start, end, this);
        }

        char[] buf = TemporaryBuffer.obtain(end - start);
        TextUtils.getChars(text, start, end, buf, 0);
        float result = measureText(buf, 0, end - start);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 181:
API Relative Path:
src.android.graphics.Paint.java-measureText(char[]-int-int)
Corresponding Source:
/**
     * Return the width of the text.
     *
     * @param text  The text to measure
     * @param start The index of the first character to start measuring
     * @param end   1 beyond the index of the last character to measure
     * @return      The width of the text
     */
    public float measureText(CharSequence text, int start, int end) {
        if (text == null) {
            throw new IllegalArgumentException("text cannot be null");
        }
        if ((start | end | (end - start) | (text.length() - end)) < 0) {
            throw new IndexOutOfBoundsException();
        }

        if (text.length() == 0 || start == end) {
            return 0f;
        }
        if (text instanceof String) {
            return measureText((String)text, start, end);
        }
        if (text instanceof SpannedString ||
            text instanceof SpannableString) {
            return measureText(text.toString(), start, end);
        }
        if (text instanceof GraphicsOperations) {
            return ((GraphicsOperations)text).measureText(start, end, this);
        }

        char[] buf = TemporaryBuffer.obtain(end - start);
        TextUtils.getChars(text, start, end, buf, 0);
        float result = measureText(buf, 0, end - start);
        TemporaryBuffer.recycle(buf);
        return result;
    }


Number 182:
API Relative Path:
src.android.graphics.Paint.java-setBidiFlags(int)
Corresponding Source:
/**
     * Set the bidi flags on the paint.
     * @hide
     */
    public void setBidiFlags(int flags) {
        // only flag value is the 3-bit BIDI control setting
        flags &= BIDI_FLAG_MASK;
        if (flags > BIDI_MAX_FLAG_VALUE) {
            throw new IllegalArgumentException("unknown bidi flag: " + flags);
        }
        mBidiFlags = flags;
    }


Number 183:
API Relative Path:
src.android.graphics.Paint.java-setFontFeatureSettings(String)
Corresponding Source:
/**
     * Set font feature settings.
     *
     * The format is the same as the CSS font-feature-settings attribute:
     * <a href="http://dev.w3.org/csswg/css-fonts/#propdef-font-feature-settings">
     *     http://dev.w3.org/csswg/css-fonts/#propdef-font-feature-settings</a>
     *
     * @see #getFontFeatureSettings()
     *
     * @param settings the font feature settings string to use, may be null.
     */
    public void setFontFeatureSettings(String settings) {
        if (settings != null && settings.equals("")) {
            settings = null;
        }
        if ((settings == null && mFontFeatureSettings == null)
                || (settings != null && settings.equals(mFontFeatureSettings))) {
            return;
        }
        mFontFeatureSettings = settings;
        nSetFontFeatureSettings(mNativePaint, settings);
    }


Number 184:
API Relative Path:
src.android.graphics.Paint.java-setTextLocale(Locale)
Corresponding Source:
/**
     * Set the text locale list to a one-member list consisting of just the locale.
     *
     * See {@link #setTextLocales(LocaleList)} for how the locale list affects
     * the way the text is drawn for some languages.
     *
     * @param locale the paint's locale value for drawing text, must not be null.
     */
    public void setTextLocale(@NonNull Locale locale) {
        if (locale == null) {
            throw new IllegalArgumentException("locale cannot be null");
        }
        if (mLocales != null && mLocales.size() == 1 && locale.equals(mLocales.get(0))) {
            return;
        }
        mLocales = new LocaleList(locale);
        syncTextLocalesWithMinikin();
    }


Number 185:
API Relative Path:
src.android.graphics.Path.java-addRoundRect(float-float-float-float-float[]-Direction)
Corresponding Source:
/**
     * Add a closed round-rectangle contour to the path. Each corner receives
     * two radius values [X, Y]. The corners are ordered top-left, top-right,
     * bottom-right, bottom-left
     *
     * @param radii Array of 8 values, 4 pairs of [X,Y] radii
     * @param dir  The direction to wind the round-rectangle's contour
     */
    public void addRoundRect(float left, float top, float right, float bottom, float[] radii,
            Direction dir) {
        if (radii.length < 8) {
            throw new ArrayIndexOutOfBoundsException("radii[] needs 8 values");
        }
        isSimplePath = false;
        native_addRoundRect(mNativePath, left, top, right, bottom, radii, dir.nativeInt);
    }


Number 186:
API Relative Path:
src.android.graphics.Path.java-addRoundRect(RectF-float[]-Direction)
Corresponding Source:
/**
     * Add a closed round-rectangle contour to the path. Each corner receives
     * two radius values [X, Y]. The corners are ordered top-left, top-right,
     * bottom-right, bottom-left
     *
     * @param rect The bounds of a round-rectangle to add to the path
     * @param radii Array of 8 values, 4 pairs of [X,Y] radii
     * @param dir  The direction to wind the round-rectangle's contour
     */
    public void addRoundRect(RectF rect, float[] radii, Direction dir) {
        if (rect == null) {
            throw new NullPointerException("need rect parameter");
        }
        addRoundRect(rect.left, rect.top, rect.right, rect.bottom, radii, dir);
    }


Number 187:
API Relative Path:
src.android.graphics.PathMeasure.java-getPosTan(float-float-float)
Corresponding Source:
/**
     * Pins distance to 0 <= distance <= getLength(), and then computes the
     * corresponding position and tangent. Returns false if there is no path,
     * or a zero-length path was specified, in which case position and tangent
     * are unchanged.
     *
     * @param distance The distance along the current contour to sample
     * @param pos If not null, eturns the sampled position (x==[0], y==[1])
     * @param tan If not null, returns the sampled tangent (x==[0], y==[1])
     * @return false if there was no path associated with this measure object
    */
    public boolean getPosTan(float distance, float pos[], float tan[]) {
        if (pos != null && pos.length < 2 ||
            tan != null && tan.length < 2) {
            throw new ArrayIndexOutOfBoundsException();
        }
        return native_getPosTan(native_instance, distance, pos, tan);
    }


Number 188:
API Relative Path:
src.android.graphics.pdf.PdfDocument.java-finishPage(Page)
Corresponding Source:
/**
     * Finishes a started page. You should always finish the last started page.
     * <p>
     * <strong>Note:</strong> Do not call this method after {@link #close()}.
     * You should not finish the same page more than once.
     * </p>
     *
     * @param page The page. Cannot be null.
     *
     * @see #startPage(PageInfo)
     */
    public void finishPage(Page page) {
        throwIfClosed();
        if (page == null) {
            throw new IllegalArgumentException("page cannot be null");
        }
        if (page != mCurrentPage) {
            throw new IllegalStateException("invalid page");
        }
        if (page.isFinished()) {
            throw new IllegalStateException("page already finished");
        }
        mPages.add(page.getInfo());
        mCurrentPage = null;
        nativeFinishPage(mNativeDocument);
        page.finish();
    }


Number 189:
API Relative Path:
src.android.graphics.pdf.PdfEditor.java-PdfEditor(ParcelFileDescriptor)
Corresponding Source:
/**
     * Creates a new instance.
     * <p>
     * <strong>Note:</strong> The provided file descriptor must be <strong>seekable</strong>,
     * i.e. its data being randomly accessed, e.g. pointing to a file. After finishing
     * with this class you must call {@link #close()}.
     * </p>
     * <p>
     * <strong>Note:</strong> This class takes ownership of the passed in file descriptor
     * and is responsible for closing it when the editor is closed.
     * </p>
     *
     * @param input Seekable file descriptor to read from.
     *
     * @throws java.io.IOException If an error occurs while reading the file.
     * @throws java.lang.SecurityException If the file requires a password or
     *         the security scheme is not supported.
     *
     * @see #close()
     */
    public PdfEditor(@NonNull ParcelFileDescriptor input) throws IOException {
        if (input == null) {
            throw new NullPointerException("input cannot be null");
        }

        final long size;
        try {
            Libcore.os.lseek(input.getFileDescriptor(), 0, OsConstants.SEEK_SET);
            size = Libcore.os.fstat(input.getFileDescriptor()).st_size;
        } catch (ErrnoException ee) {
            throw new IllegalArgumentException("file descriptor not seekable");
        }

        mInput = input;
        mNativeDocument = nativeOpen(mInput.getFd(), size);
        mPageCount = nativeGetPageCount(mNativeDocument);
        mCloseGuard.open("close");
    }


Number 190:
API Relative Path:
src.android.graphics.pdf.PdfRenderer.java-PdfRenderer(ParcelFileDescriptor)
Corresponding Source:
/**
     * Creates a new instance.
     * <p>
     * <strong>Note:</strong> The provided file descriptor must be <strong>seekable</strong>,
     * i.e. its data being randomly accessed, e.g. pointing to a file.
     * </p>
     * <p>
     * <strong>Note:</strong> This class takes ownership of the passed in file descriptor
     * and is responsible for closing it when the renderer is closed.
     * </p>
     * <p>
     * If the file is from an untrusted source it is recommended to run the renderer in a separate,
     * isolated process with minimal permissions to limit the impact of security exploits.
     * </p>
     *
     * @param input Seekable file descriptor to read from.
     *
     * @throws java.io.IOException If an error occurs while reading the file.
     * @throws java.lang.SecurityException If the file requires a password or
     *         the security scheme is not supported.
     */
    public PdfRenderer(@NonNull ParcelFileDescriptor input) throws IOException {
        if (input == null) {
            throw new NullPointerException("input cannot be null");
        }

        final long size;
        try {
            Libcore.os.lseek(input.getFileDescriptor(), 0, OsConstants.SEEK_SET);
            size = Libcore.os.fstat(input.getFileDescriptor()).st_size;
        } catch (ErrnoException ee) {
            throw new IllegalArgumentException("file descriptor not seekable");
        }

        mInput = input;
        mNativeDocument = nativeCreate(mInput.getFd(), size);
        mPageCount = nativeGetPageCount(mNativeDocument);
        mCloseGuard.open("close");
    }


Number 191:
API Relative Path:
src.android.graphics.Picture.java-writeToStream(OutputStream)
Corresponding Source:
/**
     * Write the picture contents to a stream. The data can be used to recreate
     * the picture in this or another process by calling createFromStream(...)
     * The resulting stream is NOT to be persisted across device restarts as
     * there is no guarantee that the Picture can be successfully reconstructed.
     *
     * <p>
     * <strong>Note:</strong> Prior to API level 23 a picture created from an
     * input stream cannot be replayed on a hardware accelerated canvas.
     *
     * @see #createFromStream(java.io.InputStream)
     * @deprecated The recommended alternative is to draw the picture into a
     * Bitmap from which you can persist it as raw or compressed pixels.
     */
    @Deprecated
    public void writeToStream(OutputStream stream) {
        // do explicit check before calling the native method
        if (stream == null) {
            throw new NullPointerException();
        }
        if (!nativeWriteToStream(mNativePicture, stream,
                             new byte[WORKING_STREAM_STORAGE])) {
            throw new RuntimeException();
        }
    }


Number 192:
API Relative Path:
src.android.graphics.RadialGradient.java-RadialGradient(float-float-float-int-float-TileMode)
Corresponding Source:
/** Create a shader that draws a radial gradient given the center and radius.
        @param centerX  The x-coordinate of the center of the radius
        @param centerY  The y-coordinate of the center of the radius
        @param radius   Must be positive. The radius of the circle for this gradient.
        @param colors   The colors to be distributed between the center and edge of the circle
        @param stops    May be <code>null</code>. Valid values are between <code>0.0f</code> and
                        <code>1.0f</code>. The relative position of each corresponding color in
                        the colors array. If <code>null</code>, colors are distributed evenly
                        between the center and edge of the circle.
        @param tileMode The Shader tiling mode
    */
    public RadialGradient(float centerX, float centerY, float radius,
               @NonNull int colors[], @Nullable float stops[], @NonNull TileMode tileMode) {
        if (radius <= 0) {
            throw new IllegalArgumentException("radius must be > 0");
        }
        if (colors.length < 2) {
            throw new IllegalArgumentException("needs >= 2 number of colors");
        }
        if (stops != null && colors.length != stops.length) {
            throw new IllegalArgumentException("color and position arrays must be of equal length");
        }
        mType = TYPE_COLORS_AND_POSITIONS;
        mX = centerX;
        mY = centerY;
        mRadius = radius;
        mColors = colors;
        mPositions = stops;
        mTileMode = tileMode;
        init(nativeCreate1(centerX, centerY, radius, colors, stops, tileMode.nativeInt));
    }


Number 193:
API Relative Path:
src.android.graphics.Region.java-getBounds(Rect)
Corresponding Source:
/**
     * Set the Rect to the bounds of the region. If the region is empty, the
     * Rect will be set to [0, 0, 0, 0]
     */
    public boolean getBounds(Rect r) {
        if (r == null) {
            throw new NullPointerException();
        }
        return nativeGetBounds(mNativeRegion, r);
    }


Number 194:
API Relative Path:
src.android.graphics.RegionIterator.java-next(Rect)
Corresponding Source:
/**
     * Return the next rectangle in the region. If there are no more rectangles
     * this returns false and r is unchanged. If there is at least one more,
     * this returns true and r is set to that rectangle.
     */
    public final boolean next(Rect r) {
        if (r == null) {
            throw new NullPointerException("The Rect must be provided");
        }
        return nativeNext(mNativeIter, r);
    }


Number 195:
API Relative Path:
src.android.graphics.SurfaceTexture.java-getTransformMatrix(float[])
Corresponding Source:
private native void nativeGetTransformMatrix(float[] mtx);


Number 196:
API Relative Path:
src.android.graphics.SweepGradient.java-SweepGradient(float-float-int-float)
Corresponding Source:
/**
     * A subclass of Shader that draws a sweep gradient around a center point.
     *
     * @param cx       The x-coordinate of the center
     * @param cy       The y-coordinate of the center
     * @param colors   The colors to be distributed between around the center.
     *                 There must be at least 2 colors in the array.
     * @param positions May be NULL. The relative position of
     *                 each corresponding color in the colors array, beginning
     *                 with 0 and ending with 1.0. If the values are not
     *                 monotonic, the drawing may produce unexpected results.
     *                 If positions is NULL, then the colors are automatically
     *                 spaced evenly.
     */
    public SweepGradient(float cx, float cy,
                         int colors[], float positions[]) {
        if (colors.length < 2) {
            throw new IllegalArgumentException("needs >= 2 number of colors");
        }
        if (positions != null && colors.length != positions.length) {
            throw new IllegalArgumentException(
                        "color and position arrays must be of equal length");
        }
        mType = TYPE_COLORS_AND_POSITIONS;
        mCx = cx;
        mCy = cy;
        mColors = colors;
        mPositions = positions;
        init(nativeCreate1(cx, cy, colors, positions));
    }


Number 197:
API Relative Path:
src.android.graphics.SweepGradient.java-SweepGradient(float-float-int-float)
Corresponding Source:
/**
     * A subclass of Shader that draws a sweep gradient around a center point.
     *
     * @param cx       The x-coordinate of the center
     * @param cy       The y-coordinate of the center
     * @param colors   The colors to be distributed between around the center.
     *                 There must be at least 2 colors in the array.
     * @param positions May be NULL. The relative position of
     *                 each corresponding color in the colors array, beginning
     *                 with 0 and ending with 1.0. If the values are not
     *                 monotonic, the drawing may produce unexpected results.
     *                 If positions is NULL, then the colors are automatically
     *                 spaced evenly.
     */
    public SweepGradient(float cx, float cy,
                         int colors[], float positions[]) {
        if (colors.length < 2) {
            throw new IllegalArgumentException("needs >= 2 number of colors");
        }
        if (positions != null && colors.length != positions.length) {
            throw new IllegalArgumentException(
                        "color and position arrays must be of equal length");
        }
        mType = TYPE_COLORS_AND_POSITIONS;
        mCx = cx;
        mCy = cy;
        mColors = colors;
        mPositions = positions;
        init(nativeCreate1(cx, cy, colors, positions));
    }


Number 198:
API Relative Path:
src.android.graphics.YuvImage.java-compressToJpeg(Rect-int-OutputStream)
Corresponding Source:
/**
     * Compress a rectangle region in the YuvImage to a jpeg.
     * Only ImageFormat.NV21 and ImageFormat.YUY2
     * are supported for now.
     *
     * @param rectangle The rectangle region to be compressed. The medthod checks if rectangle is
     *                  inside the image. Also, the method modifies rectangle if the chroma pixels
     *                  in it are not matched with the luma pixels in it.
     * @param quality   Hint to the compressor, 0-100. 0 meaning compress for
     *                  small size, 100 meaning compress for max quality.
     * @param stream    OutputStream to write the compressed data.
     * @return          True if the compression is successful.
     * @throws IllegalArgumentException if rectangle is invalid; quality is not within [0,
     *                  100]; or stream is null.
     */
    public boolean compressToJpeg(Rect rectangle, int quality, OutputStream stream) {
        Rect wholeImage = new Rect(0, 0, mWidth, mHeight);
        if (!wholeImage.contains(rectangle)) {
            throw new IllegalArgumentException(
                    "rectangle is not inside the image");
        }

        if (quality < 0 || quality > 100) {
            throw new IllegalArgumentException("quality must be 0..100");
        }

        if (stream == null) {
            throw new IllegalArgumentException("stream cannot be null");
        }

        adjustRectangle(rectangle);
        int[] offsets = calculateOffsets(rectangle.left, rectangle.top);

        return nativeCompressToJpeg(mData, mFormat, rectangle.width(),
                rectangle.height(), offsets, mStrides, quality, stream,
                new byte[WORKING_COMPRESS_STORAGE]);
    }


Number 199:
API Relative Path:
src.android.graphics.YuvImage.java-YuvImage(byte[]-int-int-int-int[])
Corresponding Source:
/**
     * Construct an YuvImage.
     *
     * @param yuv     The YUV data. In the case of more than one image plane, all the planes must be
     *                concatenated into a single byte array.
     * @param format  The YUV data format as defined in {@link ImageFormat}.
     * @param width   The width of the YuvImage.
     * @param height  The height of the YuvImage.
     * @param strides (Optional) Row bytes of each image plane. If yuv contains padding, the stride
     *                of each image must be provided. If strides is null, the method assumes no
     *                padding and derives the row bytes by format and width itself.
     * @throws IllegalArgumentException if format is not support; width or height <= 0; or yuv is
     *                null.
     */
    public YuvImage(byte[] yuv, int format, int width, int height, int[] strides) {
        if (format != ImageFormat.NV21 &&
                format != ImageFormat.YUY2) {
            throw new IllegalArgumentException(
                    "only support ImageFormat.NV21 " +
                    "and ImageFormat.YUY2 for now");
        }

        if (width <= 0  || height <= 0) {
            throw new IllegalArgumentException(
                    "width and height must large than 0");
        }

        if (yuv == null) {
            throw new IllegalArgumentException("yuv cannot be null");
        }

        if (strides == null) {
            mStrides = calculateStrides(width, format);
        } else {
            mStrides = strides;
        }

        mData = yuv;
        mFormat = format;
        mWidth = width;
        mHeight = height;
    }


Number 200:
API Relative Path:
src.android.hardware.Camera.java-openLegacy(int-int)
Corresponding Source:
/**
     * Creates a new Camera object to access a particular hardware camera with
     * given hal API version. If the same camera is opened by other applications
     * or the hal API version is not supported by this device, this will throw a
     * RuntimeException.
     * <p>
     * You must call {@link #release()} when you are done using the camera,
     * otherwise it will remain locked and be unavailable to other applications.
     * <p>
     * Your application should only have one Camera object active at a time for
     * a particular hardware camera.
     * <p>
     * Callbacks from other methods are delivered to the event loop of the
     * thread which called open(). If this thread has no event loop, then
     * callbacks are delivered to the main application event loop. If there is
     * no main application event loop, callbacks are not delivered.
     * <p class="caution">
     * <b>Caution:</b> On some devices, this method may take a long time to
     * complete. It is best to call this method from a worker thread (possibly
     * using {@link android.os.AsyncTask}) to avoid blocking the main
     * application UI thread.
     *
     * @param cameraId The hardware camera to access, between 0 and
     * {@link #getNumberOfCameras()}-1.
     * @param halVersion The HAL API version this camera device to be opened as.
     * @return a new Camera object, connected, locked and ready for use.
     *
     * @throws IllegalArgumentException if the {@code halVersion} is invalid
     *
     * @throws RuntimeException if opening the camera fails (for example, if the
     * camera is in use by another process or device policy manager has disabled
     * the camera).
     *
     * @see android.app.admin.DevicePolicyManager#getCameraDisabled(android.content.ComponentName)
     * @see #CAMERA_HAL_API_VERSION_1_0
     *
     * @hide
     */
    public static Camera openLegacy(int cameraId, int halVersion) {
        if (halVersion < CAMERA_HAL_API_VERSION_1_0) {
            throw new IllegalArgumentException("Invalid HAL version " + halVersion);
        }

        return new Camera(cameraId, halVersion);
    }


Number 201:
API Relative Path:
src.android.hardware.camera2.CameraManager.java-throwAsPublicException(Throwable)
Corresponding Source:
/**
     * Convert ServiceSpecificExceptions and Binder RemoteExceptions from camera binder interfaces
     * into the correct public exceptions.
     *
     * @hide
     */
    public static void throwAsPublicException(Throwable t) throws CameraAccessException {
        if (t instanceof ServiceSpecificException) {
            ServiceSpecificException e = (ServiceSpecificException) t;
            int reason = CameraAccessException.CAMERA_ERROR;
            switch(e.errorCode) {
                case ICameraService.ERROR_DISCONNECTED:
                    reason = CameraAccessException.CAMERA_DISCONNECTED;
                    break;
                case ICameraService.ERROR_DISABLED:
                    reason = CameraAccessException.CAMERA_DISABLED;
                    break;
                case ICameraService.ERROR_CAMERA_IN_USE:
                    reason = CameraAccessException.CAMERA_IN_USE;
                    break;
                case ICameraService.ERROR_MAX_CAMERAS_IN_USE:
                    reason = CameraAccessException.MAX_CAMERAS_IN_USE;
                    break;
                case ICameraService.ERROR_DEPRECATED_HAL:
                    reason = CameraAccessException.CAMERA_DEPRECATED_HAL;
                    break;
                case ICameraService.ERROR_ILLEGAL_ARGUMENT:
                case ICameraService.ERROR_ALREADY_EXISTS:
                    throw new IllegalArgumentException(e.getMessage(), e);
                case ICameraService.ERROR_PERMISSION_DENIED:
                    throw new SecurityException(e.getMessage(), e);
                case ICameraService.ERROR_TIMED_OUT:
                case ICameraService.ERROR_INVALID_OPERATION:
                default:
                    reason = CameraAccessException.CAMERA_ERROR;
            }
            throw new CameraAccessException(reason, e.getMessage(), e);
        } else if (t instanceof DeadObjectException) {
            throw new CameraAccessException(CameraAccessException.CAMERA_DISCONNECTED,
                    "Camera service has died unexpectedly",
                    t);
        } else if (t instanceof RemoteException) {
            throw new UnsupportedOperationException("An unknown RemoteException was thrown" +
                    " which should never happen.", t);
        } else if (t instanceof RuntimeException) {
            RuntimeException e = (RuntimeException) t;
            throw e;
        }
    }


Number 202:
API Relative Path:
src.android.hardware.camera2.CameraManager.java-throwAsPublicException(Throwable)
Corresponding Source:
/**
     * Convert ServiceSpecificExceptions and Binder RemoteExceptions from camera binder interfaces
     * into the correct public exceptions.
     *
     * @hide
     */
    public static void throwAsPublicException(Throwable t) throws CameraAccessException {
        if (t instanceof ServiceSpecificException) {
            ServiceSpecificException e = (ServiceSpecificException) t;
            int reason = CameraAccessException.CAMERA_ERROR;
            switch(e.errorCode) {
                case ICameraService.ERROR_DISCONNECTED:
                    reason = CameraAccessException.CAMERA_DISCONNECTED;
                    break;
                case ICameraService.ERROR_DISABLED:
                    reason = CameraAccessException.CAMERA_DISABLED;
                    break;
                case ICameraService.ERROR_CAMERA_IN_USE:
                    reason = CameraAccessException.CAMERA_IN_USE;
                    break;
                case ICameraService.ERROR_MAX_CAMERAS_IN_USE:
                    reason = CameraAccessException.MAX_CAMERAS_IN_USE;
                    break;
                case ICameraService.ERROR_DEPRECATED_HAL:
                    reason = CameraAccessException.CAMERA_DEPRECATED_HAL;
                    break;
                case ICameraService.ERROR_ILLEGAL_ARGUMENT:
                case ICameraService.ERROR_ALREADY_EXISTS:
                    throw new IllegalArgumentException(e.getMessage(), e);
                case ICameraService.ERROR_PERMISSION_DENIED:
                    throw new SecurityException(e.getMessage(), e);
                case ICameraService.ERROR_TIMED_OUT:
                case ICameraService.ERROR_INVALID_OPERATION:
                default:
                    reason = CameraAccessException.CAMERA_ERROR;
            }
            throw new CameraAccessException(reason, e.getMessage(), e);
        } else if (t instanceof DeadObjectException) {
            throw new CameraAccessException(CameraAccessException.CAMERA_DISCONNECTED,
                    "Camera service has died unexpectedly",
                    t);
        } else if (t instanceof RemoteException) {
            throw new UnsupportedOperationException("An unknown RemoteException was thrown" +
                    " which should never happen.", t);
        } else if (t instanceof RuntimeException) {
            RuntimeException e = (RuntimeException) t;
            throw e;
        }
    }


Number 203:
API Relative Path:
src.android.hardware.camera2.CameraManager.java-throwAsPublicException(Throwable)
Corresponding Source:
/**
     * Convert ServiceSpecificExceptions and Binder RemoteExceptions from camera binder interfaces
     * into the correct public exceptions.
     *
     * @hide
     */
    public static void throwAsPublicException(Throwable t) throws CameraAccessException {
        if (t instanceof ServiceSpecificException) {
            ServiceSpecificException e = (ServiceSpecificException) t;
            int reason = CameraAccessException.CAMERA_ERROR;
            switch(e.errorCode) {
                case ICameraService.ERROR_DISCONNECTED:
                    reason = CameraAccessException.CAMERA_DISCONNECTED;
                    break;
                case ICameraService.ERROR_DISABLED:
                    reason = CameraAccessException.CAMERA_DISABLED;
                    break;
                case ICameraService.ERROR_CAMERA_IN_USE:
                    reason = CameraAccessException.CAMERA_IN_USE;
                    break;
                case ICameraService.ERROR_MAX_CAMERAS_IN_USE:
                    reason = CameraAccessException.MAX_CAMERAS_IN_USE;
                    break;
                case ICameraService.ERROR_DEPRECATED_HAL:
                    reason = CameraAccessException.CAMERA_DEPRECATED_HAL;
                    break;
                case ICameraService.ERROR_ILLEGAL_ARGUMENT:
                case ICameraService.ERROR_ALREADY_EXISTS:
                    throw new IllegalArgumentException(e.getMessage(), e);
                case ICameraService.ERROR_PERMISSION_DENIED:
                    throw new SecurityException(e.getMessage(), e);
                case ICameraService.ERROR_TIMED_OUT:
                case ICameraService.ERROR_INVALID_OPERATION:
                default:
                    reason = CameraAccessException.CAMERA_ERROR;
            }
            throw new CameraAccessException(reason, e.getMessage(), e);
        } else if (t instanceof DeadObjectException) {
            throw new CameraAccessException(CameraAccessException.CAMERA_DISCONNECTED,
                    "Camera service has died unexpectedly",
                    t);
        } else if (t instanceof RemoteException) {
            throw new UnsupportedOperationException("An unknown RemoteException was thrown" +
                    " which should never happen.", t);
        } else if (t instanceof RuntimeException) {
            RuntimeException e = (RuntimeException) t;
            throw e;
        }
    }


Number 204:
API Relative Path:
src.android.hardware.camera2.CaptureResult.java-CaptureResult(CameraMetadataNative-CaptureRequest-CaptureResultExtras)
Corresponding Source:
/**
     * Takes ownership of the passed-in properties object
     *
     * <p>For internal use only</p>
     * @hide
     */
    public CaptureResult(CameraMetadataNative results, CaptureRequest parent,
            CaptureResultExtras extras) {
        if (results == null) {
            throw new IllegalArgumentException("results was null");
        }

        if (parent == null) {
            throw new IllegalArgumentException("parent was null");
        }

        if (extras == null) {
            throw new IllegalArgumentException("extras was null");
        }

        mResults = CameraMetadataNative.move(results);
        if (mResults.isEmpty()) {
            throw new AssertionError("Results must not be empty");
        }
        mRequest = parent;
        mSequenceId = extras.getRequestId();
        mFrameNumber = extras.getFrameNumber();
    }


Number 205:
API Relative Path:
src.android.hardware.camera2.CaptureResult.java-CaptureResult(CameraMetadataNative-CaptureRequest-CaptureResultExtras)
Corresponding Source:
/**
     * Takes ownership of the passed-in properties object
     *
     * <p>For internal use only</p>
     * @hide
     */
    public CaptureResult(CameraMetadataNative results, CaptureRequest parent,
            CaptureResultExtras extras) {
        if (results == null) {
            throw new IllegalArgumentException("results was null");
        }

        if (parent == null) {
            throw new IllegalArgumentException("parent was null");
        }

        if (extras == null) {
            throw new IllegalArgumentException("extras was null");
        }

        mResults = CameraMetadataNative.move(results);
        if (mResults.isEmpty()) {
            throw new AssertionError("Results must not be empty");
        }
        mRequest = parent;
        mSequenceId = extras.getRequestId();
        mFrameNumber = extras.getFrameNumber();
    }


Number 206:
API Relative Path:
src.android.hardware.camera2.CaptureResult.java-CaptureResult(CameraMetadataNative-CaptureRequest-CaptureResultExtras)
Corresponding Source:
/**
     * Takes ownership of the passed-in properties object
     *
     * <p>For internal use only</p>
     * @hide
     */
    public CaptureResult(CameraMetadataNative results, CaptureRequest parent,
            CaptureResultExtras extras) {
        if (results == null) {
            throw new IllegalArgumentException("results was null");
        }

        if (parent == null) {
            throw new IllegalArgumentException("parent was null");
        }

        if (extras == null) {
            throw new IllegalArgumentException("extras was null");
        }

        mResults = CameraMetadataNative.move(results);
        if (mResults.isEmpty()) {
            throw new AssertionError("Results must not be empty");
        }
        mRequest = parent;
        mSequenceId = extras.getRequestId();
        mFrameNumber = extras.getFrameNumber();
    }


Number 207:
API Relative Path:
src.android.hardware.camera2.CaptureResult.java-CaptureResult(CameraMetadataNative-int)
Corresponding Source:
/**
     * Creates a request-less result.
     *
     * <p><strong>For testing only.</strong></p>
     * @hide
     */
    public CaptureResult(CameraMetadataNative results, int sequenceId) {
        if (results == null) {
            throw new IllegalArgumentException("results was null");
        }

        mResults = CameraMetadataNative.move(results);
        if (mResults.isEmpty()) {
            throw new AssertionError("Results must not be empty");
        }

        mRequest = null;
        mSequenceId = sequenceId;
        mFrameNumber = -1;
    }


Number 208:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-DngCreator(CameraCharacteristics-CaptureResult)
Corresponding Source:
/**
     * Create a new DNG object.
     *
     * <p>
     * It is not necessary to call any set methods to write a well-formatted DNG file.
     * </p>
     * <p>
     * DNG metadata tags will be generated from the corresponding parameters in the
     * {@link android.hardware.camera2.CaptureResult} object.
     * </p>
     * <p>
     * For best quality DNG files, it is strongly recommended that lens shading map output is
     * enabled if supported. See {@link CaptureRequest#STATISTICS_LENS_SHADING_MAP_MODE}.
     * </p>
     * @param characteristics an object containing the static
     *          {@link android.hardware.camera2.CameraCharacteristics}.
     * @param metadata a metadata object to generate tags from.
     */
    public DngCreator(@NonNull CameraCharacteristics characteristics,
            @NonNull CaptureResult metadata) {
        if (characteristics == null || metadata == null) {
            throw new IllegalArgumentException("Null argument to DngCreator constructor");
        }

        // Find current time
        long currentTime = System.currentTimeMillis();

        // Find boot time
        long bootTimeMillis = currentTime - SystemClock.elapsedRealtime();

        // Find capture time (nanos since boot)
        Long timestamp = metadata.get(CaptureResult.SENSOR_TIMESTAMP);
        long captureTime = currentTime;
        if (timestamp != null) {
            captureTime = timestamp / 1000000 + bootTimeMillis;
        }

        // Format for metadata
        String formattedCaptureTime = sDateTimeStampFormat.format(captureTime);

        nativeInit(characteristics.getNativeCopy(), metadata.getNativeCopy(),
                formattedCaptureTime);
    }


Number 209:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-setDescription(String)
Corresponding Source:
private synchronized native void nativeSetDescription(String description);


Number 210:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-setLocation(Location)
Corresponding Source:
/**
     * Set image location metadata.
     *
     * <p>
     * The given location object must contain at least a valid time, latitude, and longitude
     * (equivalent to the values returned by {@link android.location.Location#getTime()},
     * {@link android.location.Location#getLatitude()}, and
     * {@link android.location.Location#getLongitude()} methods).
     * </p>
     *
     * @param location an {@link android.location.Location} object to set.
     * @return this {@link #DngCreator} object.
     *
     * @throws java.lang.IllegalArgumentException if the given location object doesn't
     *          contain enough information to set location metadata.
     */
    @NonNull
    public DngCreator setLocation(@NonNull Location location) {
        if (location == null) {
            throw new IllegalArgumentException("Null location passed to setLocation");
        }
        double latitude = location.getLatitude();
        double longitude = location.getLongitude();
        long time = location.getTime();

        int[] latTag = toExifLatLong(latitude);
        int[] longTag = toExifLatLong(longitude);
        String latRef = latitude >= 0 ? GPS_LAT_REF_NORTH : GPS_LAT_REF_SOUTH;
        String longRef = longitude >= 0 ? GPS_LONG_REF_EAST : GPS_LONG_REF_WEST;

        String dateTag = sExifGPSDateStamp.format(time);
        mGPSTimeStampCalendar.setTimeInMillis(time);
        int[] timeTag = new int[] { mGPSTimeStampCalendar.get(Calendar.HOUR_OF_DAY), 1,
                mGPSTimeStampCalendar.get(Calendar.MINUTE), 1,
                mGPSTimeStampCalendar.get(Calendar.SECOND), 1 };
        nativeSetGpsTags(latTag, latRef, longTag, longRef, dateTag, timeTag);
        return this;
    }


Number 211:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-setOrientation(int)
Corresponding Source:
private synchronized native void nativeSetOrientation(int orientation);


Number 212:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-setThumbnail(Bitmap)
Corresponding Source:
/**
     * Set the thumbnail image.
     *
     * <p>
     * Pixel data will be converted to a Baseline TIFF RGB image, with 8 bits per color channel.
     * The alpha channel will be discarded.  Thumbnail images with a dimension larger than
     * {@link #MAX_THUMBNAIL_DIMENSION} will be rejected.
     * </p>
     *
     * @param pixels a {@link android.graphics.Bitmap} of pixel data.
     * @return this {@link #DngCreator} object.
     * @throws java.lang.IllegalArgumentException if the given thumbnail image has a dimension
     *      larger than {@link #MAX_THUMBNAIL_DIMENSION}.
     */
    @NonNull
    public DngCreator setThumbnail(@NonNull Bitmap pixels) {
        if (pixels == null) {
            throw new IllegalArgumentException("Null argument to setThumbnail");
        }

        int width = pixels.getWidth();
        int height = pixels.getHeight();

        if (width > MAX_THUMBNAIL_DIMENSION || height > MAX_THUMBNAIL_DIMENSION) {
            throw new IllegalArgumentException("Thumbnail dimensions width,height (" + width +
                    "," + height + ") too large, dimensions must be smaller than " +
                    MAX_THUMBNAIL_DIMENSION);
        }

        ByteBuffer rgbBuffer = convertToRGB(pixels);
        nativeSetThumbnail(rgbBuffer, width, height);

        return this;
    }


Number 213:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-setThumbnail(Image)
Corresponding Source:
/**
     * Set the thumbnail image.
     *
     * <p>
     * Pixel data is interpreted as a {@link android.graphics.ImageFormat#YUV_420_888} image.
     * Thumbnail images with a dimension larger than {@link #MAX_THUMBNAIL_DIMENSION} will be
     * rejected.
     * </p>
     *
     * @param pixels an {@link android.media.Image} object with the format
     *               {@link android.graphics.ImageFormat#YUV_420_888}.
     * @return this {@link #DngCreator} object.
     * @throws java.lang.IllegalArgumentException if the given thumbnail image has a dimension
     *      larger than {@link #MAX_THUMBNAIL_DIMENSION}.
     */
    @NonNull
    public DngCreator setThumbnail(@NonNull Image pixels) {
        if (pixels == null) {
            throw new IllegalArgumentException("Null argument to setThumbnail");
        }

        int format = pixels.getFormat();
        if (format != ImageFormat.YUV_420_888) {
            throw new IllegalArgumentException("Unsupported Image format " + format);
        }

        int width = pixels.getWidth();
        int height = pixels.getHeight();

        if (width > MAX_THUMBNAIL_DIMENSION || height > MAX_THUMBNAIL_DIMENSION) {
            throw new IllegalArgumentException("Thumbnail dimensions width,height (" + width +
                    "," + height + ") too large, dimensions must be smaller than " +
                    MAX_THUMBNAIL_DIMENSION);
        }

        ByteBuffer rgbBuffer = convertToRGB(pixels);
        nativeSetThumbnail(rgbBuffer, width, height);

        return this;
    }


Number 214:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeByteBuffer(OutputStream-Size-ByteBuffer-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * <p>
     * Any mark or limit set on this {@link ByteBuffer} is ignored, and will be cleared by this
     * method.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.nio.ByteBuffer} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     */
    public void writeByteBuffer(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull ByteBuffer pixels, @IntRange(from=0) long offset)
            throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeByteBuffer");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeByteBuffer");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeByteBuffer");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeByteBuffer");
        }

        int width = size.getWidth();
        int height = size.getHeight();

        writeByteBuffer(width, height, pixels, dngOutput, DEFAULT_PIXEL_STRIDE,
                width * DEFAULT_PIXEL_STRIDE, offset);
    }


Number 215:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeByteBuffer(OutputStream-Size-ByteBuffer-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * <p>
     * Any mark or limit set on this {@link ByteBuffer} is ignored, and will be cleared by this
     * method.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.nio.ByteBuffer} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     */
    public void writeByteBuffer(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull ByteBuffer pixels, @IntRange(from=0) long offset)
            throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeByteBuffer");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeByteBuffer");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeByteBuffer");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeByteBuffer");
        }

        int width = size.getWidth();
        int height = size.getHeight();

        writeByteBuffer(width, height, pixels, dngOutput, DEFAULT_PIXEL_STRIDE,
                width * DEFAULT_PIXEL_STRIDE, offset);
    }


Number 216:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeByteBuffer(OutputStream-Size-ByteBuffer-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * <p>
     * Any mark or limit set on this {@link ByteBuffer} is ignored, and will be cleared by this
     * method.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.nio.ByteBuffer} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     */
    public void writeByteBuffer(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull ByteBuffer pixels, @IntRange(from=0) long offset)
            throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeByteBuffer");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeByteBuffer");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeByteBuffer");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeByteBuffer");
        }

        int width = size.getWidth();
        int height = size.getHeight();

        writeByteBuffer(width, height, pixels, dngOutput, DEFAULT_PIXEL_STRIDE,
                width * DEFAULT_PIXEL_STRIDE, offset);
    }


Number 217:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeByteBuffer(OutputStream-Size-ByteBuffer-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * <p>
     * Any mark or limit set on this {@link ByteBuffer} is ignored, and will be cleared by this
     * method.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.nio.ByteBuffer} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     */
    public void writeByteBuffer(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull ByteBuffer pixels, @IntRange(from=0) long offset)
            throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeByteBuffer");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeByteBuffer");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeByteBuffer");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeByteBuffer");
        }

        int width = size.getWidth();
        int height = size.getHeight();

        writeByteBuffer(width, height, pixels, dngOutput, DEFAULT_PIXEL_STRIDE,
                width * DEFAULT_PIXEL_STRIDE, offset);
    }


Number 218:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeImage(OutputStream-Image)
Corresponding Source:
/**
     * Write the pixel data to a DNG file with the currently configured metadata.
     *
     * <p>
     * For this method to succeed, the {@link android.media.Image} input must contain
     * {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data, otherwise an
     * {@link java.lang.IllegalArgumentException} will be thrown.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param pixels an {@link android.media.Image} to write.
     *
     * @throws java.io.IOException if an error was encountered in the output stream.
     * @throws java.lang.IllegalArgumentException if an image with an unsupported format was used.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     */
    public void writeImage(@NonNull OutputStream dngOutput, @NonNull Image pixels)
            throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput to writeImage");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels to writeImage");
        }

        int format = pixels.getFormat();
        if (format != ImageFormat.RAW_SENSOR) {
            throw new IllegalArgumentException("Unsupported image format " + format);
        }

        Image.Plane[] planes = pixels.getPlanes();
        if (planes == null || planes.length <= 0) {
            throw new IllegalArgumentException("Image with no planes passed to writeImage");
        }

        ByteBuffer buf = planes[0].getBuffer();
        writeByteBuffer(pixels.getWidth(), pixels.getHeight(), buf, dngOutput,
                planes[0].getPixelStride(), planes[0].getRowStride(), 0);
    }


Number 219:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeImage(OutputStream-Image)
Corresponding Source:
/**
     * Write the pixel data to a DNG file with the currently configured metadata.
     *
     * <p>
     * For this method to succeed, the {@link android.media.Image} input must contain
     * {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data, otherwise an
     * {@link java.lang.IllegalArgumentException} will be thrown.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param pixels an {@link android.media.Image} to write.
     *
     * @throws java.io.IOException if an error was encountered in the output stream.
     * @throws java.lang.IllegalArgumentException if an image with an unsupported format was used.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     */
    public void writeImage(@NonNull OutputStream dngOutput, @NonNull Image pixels)
            throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput to writeImage");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels to writeImage");
        }

        int format = pixels.getFormat();
        if (format != ImageFormat.RAW_SENSOR) {
            throw new IllegalArgumentException("Unsupported image format " + format);
        }

        Image.Plane[] planes = pixels.getPlanes();
        if (planes == null || planes.length <= 0) {
            throw new IllegalArgumentException("Image with no planes passed to writeImage");
        }

        ByteBuffer buf = planes[0].getBuffer();
        writeByteBuffer(pixels.getWidth(), pixels.getHeight(), buf, dngOutput,
                planes[0].getPixelStride(), planes[0].getRowStride(), 0);
    }


Number 220:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeInputStream(OutputStream-Size-InputStream-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.io.InputStream} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     * @throws java.lang.IllegalArgumentException if the size passed in does not match the
     */
    public void writeInputStream(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull InputStream pixels, @IntRange(from=0) long offset) throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeInputStream");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeInputStream");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeInputStream");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeInputStream");
        }

        int width = size.getWidth();
        int height = size.getHeight();
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("Size with invalid width, height: (" + width + "," +
                    height + ") passed to writeInputStream");
        }
        nativeWriteInputStream(dngOutput, pixels, width, height, offset);
    }


Number 221:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeInputStream(OutputStream-Size-InputStream-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.io.InputStream} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     * @throws java.lang.IllegalArgumentException if the size passed in does not match the
     */
    public void writeInputStream(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull InputStream pixels, @IntRange(from=0) long offset) throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeInputStream");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeInputStream");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeInputStream");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeInputStream");
        }

        int width = size.getWidth();
        int height = size.getHeight();
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("Size with invalid width, height: (" + width + "," +
                    height + ") passed to writeInputStream");
        }
        nativeWriteInputStream(dngOutput, pixels, width, height, offset);
    }


Number 222:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeInputStream(OutputStream-Size-InputStream-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.io.InputStream} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     * @throws java.lang.IllegalArgumentException if the size passed in does not match the
     */
    public void writeInputStream(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull InputStream pixels, @IntRange(from=0) long offset) throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeInputStream");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeInputStream");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeInputStream");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeInputStream");
        }

        int width = size.getWidth();
        int height = size.getHeight();
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("Size with invalid width, height: (" + width + "," +
                    height + ") passed to writeInputStream");
        }
        nativeWriteInputStream(dngOutput, pixels, width, height, offset);
    }


Number 223:
API Relative Path:
src.android.hardware.camera2.DngCreator.java-writeInputStream(OutputStream-Size-InputStream-long)
Corresponding Source:
/**
     * Write the {@link android.graphics.ImageFormat#RAW_SENSOR} pixel data to a DNG file with
     * the currently configured metadata.
     *
     * <p>
     * Raw pixel data must have 16 bits per pixel, and the input must contain at least
     * {@code offset + 2 * width * height)} bytes.  The width and height of
     * the input are taken from the width and height set in the {@link DngCreator} metadata tags,
     * and will typically be equal to the width and height of
     * {@link CameraCharacteristics#SENSOR_INFO_PRE_CORRECTION_ACTIVE_ARRAY_SIZE}.  Prior to
     * API level 23, this was always the same as
     * {@link CameraCharacteristics#SENSOR_INFO_ACTIVE_ARRAY_SIZE}.
     * The pixel layout in the input is determined from the reported color filter arrangement (CFA)
     * set in {@link CameraCharacteristics#SENSOR_INFO_COLOR_FILTER_ARRANGEMENT}.  If insufficient
     * metadata is available to write a well-formatted DNG file, an
     * {@link java.lang.IllegalStateException} will be thrown.
     * </p>
     *
     * @param dngOutput an {@link java.io.OutputStream} to write the DNG file to.
     * @param size the {@link Size} of the image to write, in pixels.
     * @param pixels an {@link java.io.InputStream} of pixel data to write.
     * @param offset the offset of the raw image in bytes.  This indicates how many bytes will
     *               be skipped in the input before any pixel data is read.
     *
     * @throws IOException if an error was encountered in the input or output stream.
     * @throws java.lang.IllegalStateException if not enough metadata information has been
     *          set to write a well-formatted DNG file.
     * @throws java.lang.IllegalArgumentException if the size passed in does not match the
     */
    public void writeInputStream(@NonNull OutputStream dngOutput, @NonNull Size size,
            @NonNull InputStream pixels, @IntRange(from=0) long offset) throws IOException {
        if (dngOutput == null) {
            throw new IllegalArgumentException("Null dngOutput passed to writeInputStream");
        } else if (size == null) {
            throw new IllegalArgumentException("Null size passed to writeInputStream");
        } else if (pixels == null) {
            throw new IllegalArgumentException("Null pixels passed to writeInputStream");
        } else if (offset < 0) {
            throw new IllegalArgumentException("Negative offset passed to writeInputStream");
        }

        int width = size.getWidth();
        int height = size.getHeight();
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("Size with invalid width, height: (" + width + "," +
                    height + ") passed to writeInputStream");
        }
        nativeWriteInputStream(dngOutput, pixels, width, height, offset);
    }


Number 224:
API Relative Path:
src.android.hardware.camera2.impl.CameraDeviceImpl.java-checkHandler(Handler)
Corresponding Source:
/**
     * Default handler management.
     *
     * <p>
     * If handler is null, get the current thread's
     * Looper to create a Handler with. If no looper exists, throw {@code IllegalArgumentException}.
     * </p>
     */
    static Handler checkHandler(Handler handler) {
        if (handler == null) {
            Looper looper = Looper.myLooper();
            if (looper == null) {
                throw new IllegalArgumentException(
                    "No handler given, and current thread has no looper!");
            }
            handler = new Handler(looper);
        }
        return handler;
    }


Number 225:
API Relative Path:
src.android.hardware.camera2.impl.CameraDeviceImpl.java-configureStreamsChecked(InputConfiguration-List-boolean)
Corresponding Source:
/**
     * Attempt to configure the input and outputs; the device goes to idle and then configures the
     * new input and outputs if possible.
     *
     * <p>The configuration may gracefully fail, if input configuration is not supported,
     * if there are too many outputs, if the formats are not supported, or if the sizes for that
     * format is not supported. In this case this function will return {@code false} and the
     * unconfigured callback will be fired.</p>
     *
     * <p>If the configuration succeeds (with 1 or more outputs with or without an input),
     * then the idle callback is fired. Unconfiguring the device always fires the idle callback.</p>
     *
     * @param inputConfig input configuration or {@code null} for no input
     * @param outputs a list of one or more surfaces, or {@code null} to unconfigure
     * @param isConstrainedHighSpeed If the streams configuration is for constrained high speed output.
     * @return whether or not the configuration was successful
     *
     * @throws CameraAccessException if there were any unexpected problems during configuration
     */
    public boolean configureStreamsChecked(InputConfiguration inputConfig,
            List<OutputConfiguration> outputs, boolean isConstrainedHighSpeed)
                    throws CameraAccessException {
        // Treat a null input the same an empty list
        if (outputs == null) {
            outputs = new ArrayList<OutputConfiguration>();
        }
        if (outputs.size() == 0 && inputConfig != null) {
            throw new IllegalArgumentException("cannot configure an input stream without " +
                    "any output streams");
        }

        checkInputConfiguration(inputConfig);

        boolean success = false;

        synchronized(mInterfaceLock) {
            checkIfCameraClosedOrInError();
            // Streams to create
            HashSet<OutputConfiguration> addSet = new HashSet<OutputConfiguration>(outputs);
            // Streams to delete
            List<Integer> deleteList = new ArrayList<Integer>();

            // Determine which streams need to be created, which to be deleted
            for (int i = 0; i < mConfiguredOutputs.size(); ++i) {
                int streamId = mConfiguredOutputs.keyAt(i);
                OutputConfiguration outConfig = mConfiguredOutputs.valueAt(i);

                if (!outputs.contains(outConfig)) {
                    deleteList.add(streamId);
                } else {
                    addSet.remove(outConfig);  // Don't create a stream previously created
                }
            }

            mDeviceHandler.post(mCallOnBusy);
            stopRepeating();

            try {
                waitUntilIdle();

                mRemoteDevice.beginConfigure();

                // reconfigure the input stream if the input configuration is different.
                InputConfiguration currentInputConfig = mConfiguredInput.getValue();
                if (inputConfig != currentInputConfig &&
                        (inputConfig == null || !inputConfig.equals(currentInputConfig))) {
                    if (currentInputConfig != null) {
                        mRemoteDevice.deleteStream(mConfiguredInput.getKey());
                        mConfiguredInput = new SimpleEntry<Integer, InputConfiguration>(
                                REQUEST_ID_NONE, null);
                    }
                    if (inputConfig != null) {
                        int streamId = mRemoteDevice.createInputStream(inputConfig.getWidth(),
                                inputConfig.getHeight(), inputConfig.getFormat());
                        mConfiguredInput = new SimpleEntry<Integer, InputConfiguration>(
                                streamId, inputConfig);
                    }
                }

                // Delete all streams first (to free up HW resources)
                for (Integer streamId : deleteList) {
                    mRemoteDevice.deleteStream(streamId);
                    mConfiguredOutputs.delete(streamId);
                }

                // Add all new streams
                for (OutputConfiguration outConfig : outputs) {
                    if (addSet.contains(outConfig)) {
                        int streamId = mRemoteDevice.createStream(outConfig);
                        mConfiguredOutputs.put(streamId, outConfig);
                    }
                }

                mRemoteDevice.endConfigure(isConstrainedHighSpeed);

                success = true;
            } catch (IllegalArgumentException e) {
                // OK. camera service can reject stream config if it's not supported by HAL
                // This is only the result of a programmer misusing the camera2 api.
                Log.w(TAG, "Stream configuration failed due to: " + e.getMessage());
                return false;
            } catch (CameraAccessException e) {
                if (e.getReason() == CameraAccessException.CAMERA_IN_USE) {
                    throw new IllegalStateException("The camera is currently busy." +
                            " You must wait until the previous operation completes.", e);
                }
                throw e;
            } finally {
                if (success && outputs.size() > 0) {
                    mDeviceHandler.post(mCallOnIdle);
                } else {
                    // Always return to the 'unconfigured' state if we didn't hit a fatal error
                    mDeviceHandler.post(mCallOnUnconfigured);
                }
            }
        }

        return success;
    }


Number 226:
API Relative Path:
src.android.hardware.camera2.impl.CameraMetadataNative.java-getAllVendorKeys(Class)
Corresponding Source:
/**
     * Return a list containing keys of the given key class for all defined vendor tags.
     *
     * @hide
     */
    public static <K> ArrayList<K> getAllVendorKeys(Class<K> keyClass) {
        if (keyClass == null) {
            throw new NullPointerException();
        }
        return (ArrayList<K>) nativeGetAllVendorKeys(keyClass);
    }


Number 227:
API Relative Path:
src.android.hardware.camera2.legacy.LegacyCameraDevice.java-submitRequestList(CaptureRequest[]-boolean)
Corresponding Source:
/**
     * Submit a burst of capture requests.
     *
     * @param requestList a list of capture requests to execute.
     * @param repeating {@code true} if this burst is repeating.
     * @return the submission info, including the new request id, and the last frame number, which
     *   contains either the frame number of the last frame that will be returned for this request,
     *   or the frame number of the last frame that will be returned for the current repeating
     *   request if this burst is set to be repeating.
     */
    public SubmitInfo submitRequestList(CaptureRequest[] requestList, boolean repeating) {
        if (requestList == null || requestList.length == 0) {
            Log.e(TAG, "submitRequestList - Empty/null requests are not allowed");
            throw new ServiceSpecificException(BAD_VALUE,
                    "submitRequestList - Empty/null requests are not allowed");
        }

        List<Long> surfaceIds;

        try {
            surfaceIds = (mConfiguredSurfaces == null) ? new ArrayList<Long>() :
                    getSurfaceIds(mConfiguredSurfaces);
        } catch (BufferQueueAbandonedException e) {
            throw new ServiceSpecificException(BAD_VALUE,
                    "submitRequestList - configured surface is abandoned.");
        }

        // Make sure that there all requests have at least 1 surface; all surfaces are non-null
        for (CaptureRequest request : requestList) {
            if (request.getTargets().isEmpty()) {
                Log.e(TAG, "submitRequestList - "
                        + "Each request must have at least one Surface target");
                throw new ServiceSpecificException(BAD_VALUE,
                        "submitRequestList - "
                        + "Each request must have at least one Surface target");
            }

            for (Surface surface : request.getTargets()) {
                if (surface == null) {
                    Log.e(TAG, "submitRequestList - Null Surface targets are not allowed");
                    throw new ServiceSpecificException(BAD_VALUE,
                            "submitRequestList - Null Surface targets are not allowed");
                } else if (mConfiguredSurfaces == null) {
                    Log.e(TAG, "submitRequestList - must configure " +
                            " device with valid surfaces before submitting requests");
                    throw new ServiceSpecificException(INVALID_OPERATION,
                            "submitRequestList - must configure " +
                            " device with valid surfaces before submitting requests");
                } else if (!containsSurfaceId(surface, surfaceIds)) {
                    Log.e(TAG, "submitRequestList - cannot use a surface that wasn't configured");
                    throw new ServiceSpecificException(BAD_VALUE,
                            "submitRequestList - cannot use a surface that wasn't configured");
                }
            }
        }

        // TODO: further validation of request here
        mIdle.close();
        return mRequestThreadManager.submitCaptureRequests(requestList, repeating);
    }


Number 228:
API Relative Path:
src.android.hardware.camera2.legacy.LegacyExceptionUtils.java-throwOnError(int)
Corresponding Source:
/**
     * Throw error codes used by legacy device methods as exceptions.
     *
     * <p>Non-negative return values are passed through, negative return values are thrown as
     * exceptions.</p>
     *
     * @param errorFlag error to throw as an exception.
     * @throws {@link BufferQueueAbandonedException} for -ENODEV.
     * @throws {@link UnsupportedOperationException} for an unknown negative error code.
     * @return {@code errorFlag} if the value was non-negative, throws otherwise.
     */
    public static int throwOnError(int errorFlag) throws BufferQueueAbandonedException {
        if (errorFlag == NO_ERROR) {
            return NO_ERROR;
        } else if (errorFlag == -ENODEV) {
            throw new BufferQueueAbandonedException();
        }

        if (errorFlag < 0) {
            throw new UnsupportedOperationException("Unknown error " + errorFlag);
        }
        return errorFlag;
    }


Number 229:
API Relative Path:
src.android.hardware.camera2.legacy.LegacyExceptionUtils.java-throwOnError(int)
Corresponding Source:
/**
     * Throw error codes used by legacy device methods as exceptions.
     *
     * <p>Non-negative return values are passed through, negative return values are thrown as
     * exceptions.</p>
     *
     * @param errorFlag error to throw as an exception.
     * @throws {@link BufferQueueAbandonedException} for -ENODEV.
     * @throws {@link UnsupportedOperationException} for an unknown negative error code.
     * @return {@code errorFlag} if the value was non-negative, throws otherwise.
     */
    public static int throwOnError(int errorFlag) throws BufferQueueAbandonedException {
        if (errorFlag == NO_ERROR) {
            return NO_ERROR;
        } else if (errorFlag == -ENODEV) {
            throw new BufferQueueAbandonedException();
        }

        if (errorFlag < 0) {
            throw new UnsupportedOperationException("Unknown error " + errorFlag);
        }
        return errorFlag;
    }


Number 230:
API Relative Path:
src.android.hardware.camera2.marshal.MarshalHelpers.java-checkNativeTypeEquals(int-int)
Corresponding Source:
/**
     * Ensure that the expected and actual native types are equal.
     *
     * @param expectedNativeType the expected native type
     * @param actualNativeType the actual native type
     * @return the actual native type
     *
     * @throws UnsupportedOperationException if the types are not equal
     */
    public static int checkNativeTypeEquals(int expectedNativeType, int actualNativeType) {
        if (expectedNativeType != actualNativeType) {
            throw new UnsupportedOperationException(
                    String.format("Expected native type %d, but got %d",
                            expectedNativeType, actualNativeType));
        }

        return actualNativeType;
    }


Number 231:
API Relative Path:
src.android.hardware.camera2.params.BlackLevelPattern.java-BlackLevelPattern(int[])
Corresponding Source:
/**
     * Create a new {@link BlackLevelPattern} from a given offset array.
     *
     * <p>The given offset array must contain offsets for each color channel in
     * a 2x2 pattern corresponding to the color filter arrangement.  Offsets are
     * given in row-column scan order.</p>
     *
     * @param offsets an array containing a 2x2 pattern of offsets.
     *
     * @throws IllegalArgumentException if the given array has an incorrect length.
     * @throws NullPointerException if the given array is null.
     * @hide
     */
    public BlackLevelPattern(int[] offsets) {
        if (offsets == null) {
            throw new NullPointerException("Null offsets array passed to constructor");
        }
        if (offsets.length < COUNT) {
            throw new IllegalArgumentException("Invalid offsets array length");
        }
        mCfaOffsets = Arrays.copyOf(offsets, COUNT);
    }


Number 232:
API Relative Path:
src.android.hardware.camera2.params.BlackLevelPattern.java-BlackLevelPattern(int[])
Corresponding Source:
/**
     * Create a new {@link BlackLevelPattern} from a given offset array.
     *
     * <p>The given offset array must contain offsets for each color channel in
     * a 2x2 pattern corresponding to the color filter arrangement.  Offsets are
     * given in row-column scan order.</p>
     *
     * @param offsets an array containing a 2x2 pattern of offsets.
     *
     * @throws IllegalArgumentException if the given array has an incorrect length.
     * @throws NullPointerException if the given array is null.
     * @hide
     */
    public BlackLevelPattern(int[] offsets) {
        if (offsets == null) {
            throw new NullPointerException("Null offsets array passed to constructor");
        }
        if (offsets.length < COUNT) {
            throw new IllegalArgumentException("Invalid offsets array length");
        }
        mCfaOffsets = Arrays.copyOf(offsets, COUNT);
    }


Number 233:
API Relative Path:
src.android.hardware.camera2.params.BlackLevelPattern.java-copyTo(int[]-int)
Corresponding Source:
/**
     * Copy the ColorChannel offsets into the destination vector.
     *
     * <p>Offsets are given in row-column scan order for a given 2x2 color pattern.</p>
     *
     * @param destination an array big enough to hold at least {@value #COUNT} elements after the
     *          {@code offset}
     * @param offset a non-negative offset into the array
     *
     * @throws IllegalArgumentException if the offset is invalid.
     * @throws ArrayIndexOutOfBoundsException if the destination vector is too small.
     * @throws NullPointerException if the destination is null.
     */
    public void copyTo(int[] destination, int offset) {
        checkNotNull(destination, "destination must not be null");
        if (offset < 0) {
            throw new IllegalArgumentException("Null offset passed to copyTo");
        }
        if (destination.length - offset < COUNT) {
            throw new ArrayIndexOutOfBoundsException("destination too small to fit elements");
        }
        for (int i = 0; i < COUNT; ++i) {
            destination[offset + i] = mCfaOffsets[i];
        }
    }


Number 234:
API Relative Path:
src.android.hardware.camera2.params.ColorSpaceTransform.java-ColorSpaceTransform(int[])
Corresponding Source:
/**
     * Create a new immutable {@link ColorSpaceTransform} instance from an {@code int} array.
     *
     * <p>The elements must be stored in a row-major order. Each rational is stored
     * contiguously as a {@code (numerator, denominator)} pair.</p>
     *
     * <p>In particular:<pre>{@code
     * int[] elements = new int[
     *     N11, D11, N12, D12, N13, D13,
     *     N21, D21, N22, D22, N23, D23,
     *     N31, D31, N32, D32, N33, D33
     * ];
     *
     * new ColorSpaceTransform(elements)}</pre>
     *
     * where {@code Nij} and {@code Dij} is the numerator and denominator for row {@code i} and
     * column {@code j}.</p>
     *
     * @param elements An array of {@code 18} elements
     *
     * @throws IllegalArgumentException
     *            if the count of {@code elements} is not {@code 18}
     * @throws NullPointerException
     *            if {@code elements} is {@code null}
     */
    public ColorSpaceTransform(int[] elements) {
        checkNotNull(elements, "elements must not be null");
        if (elements.length != COUNT_INT) {
            throw new IllegalArgumentException("elements must be " + COUNT_INT + " length");
        }

        for (int i = 0; i < elements.length; ++i) {
            checkNotNull(elements, "element " + i + " must not be null");
        }

        mElements = Arrays.copyOf(elements, elements.length);
    }


Number 235:
API Relative Path:
src.android.hardware.camera2.params.ColorSpaceTransform.java-ColorSpaceTransform(Rational[])
Corresponding Source:
/**
     * Create a new immutable {@link ColorSpaceTransform} instance from a {@link Rational} array.
     *
     * <p>The elements must be stored in a row-major order.</p>
     *
     * @param elements An array of {@code 9} elements
     *
     * @throws IllegalArgumentException
     *            if the count of {@code elements} is not {@code 9}
     * @throws NullPointerException
     *            if {@code elements} or any sub-element is {@code null}
     */
    public ColorSpaceTransform(Rational[] elements) {

        checkNotNull(elements, "elements must not be null");
        if (elements.length != COUNT) {
            throw new IllegalArgumentException("elements must be " + COUNT + " length");
        }

        mElements = new int[COUNT_INT];

        for (int i = 0; i < elements.length; ++i) {
            checkNotNull(elements, "element[" + i + "] must not be null");
            mElements[i * RATIONAL_SIZE + OFFSET_NUMERATOR] = elements[i].getNumerator();
            mElements[i * RATIONAL_SIZE + OFFSET_DENOMINATOR] = elements[i].getDenominator();
        }
    }


Number 236:
API Relative Path:
src.android.hardware.camera2.params.ColorSpaceTransform.java-copyElements(int[]-int)
Corresponding Source:
/**
     * Copy the {@link Rational} elements in row-major order from this matrix into the destination.
     *
     * <p>Each element is stored as a contiguous rational packed as a
     * {@code (numerator, denominator)} pair of ints, identical to the
     * {@link ColorSpaceTransform#ColorSpaceTransform(int[]) constructor}.</p>
     *
     * @param destination
     *          an array big enough to hold at least {@code 18} elements after the
     *          {@code offset}
     * @param offset
     *          a non-negative offset into the array
     * @throws NullPointerException
     *          If {@code destination} was {@code null}
     * @throws ArrayIndexOutOfBoundsException
     *          If there's not enough room to write the elements at the specified destination and
     *          offset.
     *
     * @see ColorSpaceTransform#ColorSpaceTransform(int[])
     */
    public void copyElements(int[] destination, int offset) {
        checkArgumentNonnegative(offset, "offset must not be negative");
        checkNotNull(destination, "destination must not be null");
        if (destination.length - offset < COUNT_INT) {
            throw new ArrayIndexOutOfBoundsException("destination too small to fit elements");
        }

        // Manual copy faster than System#arraycopy for very small loops
        for (int i = 0; i < COUNT_INT; ++i) {
            destination[i + offset] = mElements[i];
        }
    }


Number 237:
API Relative Path:
src.android.hardware.camera2.params.ColorSpaceTransform.java-copyElements(Rational[]-int)
Corresponding Source:
/**
     * Copy the {@link Rational} elements in row-major order from this matrix into the destination.
     *
     * @param destination
     *          an array big enough to hold at least {@code 9} elements after the
     *          {@code offset}
     * @param offset
     *          a non-negative offset into the array
     * @throws NullPointerException
     *          If {@code destination} was {@code null}
     * @throws ArrayIndexOutOfBoundsException
     *          If there's not enough room to write the elements at the specified destination and
     *          offset.
     */
    public void copyElements(Rational[] destination, int offset) {
        checkArgumentNonnegative(offset, "offset must not be negative");
        checkNotNull(destination, "destination must not be null");
        if (destination.length - offset < COUNT) {
            throw new ArrayIndexOutOfBoundsException("destination too small to fit elements");
        }

        for (int i = 0, j = 0; i < COUNT; ++i, j += RATIONAL_SIZE) {
            int numerator = mElements[j + OFFSET_NUMERATOR];
            int denominator = mElements[j + OFFSET_DENOMINATOR];

            destination[i + offset] = new Rational(numerator, denominator);
        }
    }


Number 238:
API Relative Path:
src.android.hardware.camera2.params.ColorSpaceTransform.java-getElement(int-int)
Corresponding Source:
/**
     * Get an element of this matrix by its row and column.
     *
     * <p>The rows must be within the range [0, 3),
     * and the column must be within the range [0, 3).</p>
     *
     * @return element (non-{@code null})
     *
     * @throws IllegalArgumentException if column or row was out of range
     */
    public Rational getElement(int column, int row) {
        if (column < 0 || column >= COLUMNS) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= ROWS) {
            throw new IllegalArgumentException("row out of range");
        }

        int numerator = mElements[(row * COLUMNS + column) * RATIONAL_SIZE + OFFSET_NUMERATOR];
        int denominator = mElements[(row * COLUMNS + column) * RATIONAL_SIZE + OFFSET_DENOMINATOR];

        return new Rational(numerator, denominator);
    }


Number 239:
API Relative Path:
src.android.hardware.camera2.params.ColorSpaceTransform.java-getElement(int-int)
Corresponding Source:
/**
     * Get an element of this matrix by its row and column.
     *
     * <p>The rows must be within the range [0, 3),
     * and the column must be within the range [0, 3).</p>
     *
     * @return element (non-{@code null})
     *
     * @throws IllegalArgumentException if column or row was out of range
     */
    public Rational getElement(int column, int row) {
        if (column < 0 || column >= COLUMNS) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= ROWS) {
            throw new IllegalArgumentException("row out of range");
        }

        int numerator = mElements[(row * COLUMNS + column) * RATIONAL_SIZE + OFFSET_NUMERATOR];
        int denominator = mElements[(row * COLUMNS + column) * RATIONAL_SIZE + OFFSET_DENOMINATOR];

        return new Rational(numerator, denominator);
    }


Number 240:
API Relative Path:
src.android.hardware.camera2.params.Face.java-Face(Rect-int-int-Point-Point-Point)
Corresponding Source:
/**
     * Create a new face with all fields set.
     *
     * <p>The id, leftEyePosition, rightEyePosition, and mouthPosition are considered optional.
     * They are only required when the {@link CaptureResult} reports that the value of key
     * {@link CaptureResult#STATISTICS_FACE_DETECT_MODE} is
     * {@link CameraMetadata#STATISTICS_FACE_DETECT_MODE_FULL}.
     * If the id is {@value #ID_UNSUPPORTED} then the leftEyePosition, rightEyePosition, and
     * mouthPositions are guaranteed to be {@code null}. Otherwise, each of leftEyePosition,
     * rightEyePosition, and mouthPosition may be independently null or not-null.</p>
     *
     * @param bounds Bounds of the face.
     * @param score Confidence level between {@value #SCORE_MIN}-{@value #SCORE_MAX}.
     * @param id A unique ID per face visible to the tracker.
     * @param leftEyePosition The position of the left eye.
     * @param rightEyePosition The position of the right eye.
     * @param mouthPosition The position of the mouth.
     *
     * @throws IllegalArgumentException
     *             if bounds is {@code null},
     *             or if the confidence is not in the range of
     *             {@value #SCORE_MIN}-{@value #SCORE_MAX},
     *             or if id is {@value #ID_UNSUPPORTED} and
     *               leftEyePosition/rightEyePosition/mouthPosition aren't all null,
     *             or else if id is negative.
     *
     * @hide
     */
    public Face(Rect bounds, int score, int id,
            Point leftEyePosition, Point rightEyePosition, Point mouthPosition) {
        checkNotNull("bounds", bounds);
        if (score < SCORE_MIN || score > SCORE_MAX) {
            throw new IllegalArgumentException("Confidence out of range");
        } else if (id < 0 && id != ID_UNSUPPORTED) {
            throw new IllegalArgumentException("Id out of range");
        }
        if (id == ID_UNSUPPORTED) {
            checkNull("leftEyePosition", leftEyePosition);
            checkNull("rightEyePosition", rightEyePosition);
            checkNull("mouthPosition", mouthPosition);
        }

        mBounds = bounds;
        mScore = score;
        mId = id;
        mLeftEye = leftEyePosition;
        mRightEye = rightEyePosition;
        mMouth = mouthPosition;
    }


Number 241:
API Relative Path:
src.android.hardware.camera2.params.Face.java-Face(Rect-int-int-Point-Point-Point)
Corresponding Source:
/**
     * Create a new face with all fields set.
     *
     * <p>The id, leftEyePosition, rightEyePosition, and mouthPosition are considered optional.
     * They are only required when the {@link CaptureResult} reports that the value of key
     * {@link CaptureResult#STATISTICS_FACE_DETECT_MODE} is
     * {@link CameraMetadata#STATISTICS_FACE_DETECT_MODE_FULL}.
     * If the id is {@value #ID_UNSUPPORTED} then the leftEyePosition, rightEyePosition, and
     * mouthPositions are guaranteed to be {@code null}. Otherwise, each of leftEyePosition,
     * rightEyePosition, and mouthPosition may be independently null or not-null.</p>
     *
     * @param bounds Bounds of the face.
     * @param score Confidence level between {@value #SCORE_MIN}-{@value #SCORE_MAX}.
     * @param id A unique ID per face visible to the tracker.
     * @param leftEyePosition The position of the left eye.
     * @param rightEyePosition The position of the right eye.
     * @param mouthPosition The position of the mouth.
     *
     * @throws IllegalArgumentException
     *             if bounds is {@code null},
     *             or if the confidence is not in the range of
     *             {@value #SCORE_MIN}-{@value #SCORE_MAX},
     *             or if id is {@value #ID_UNSUPPORTED} and
     *               leftEyePosition/rightEyePosition/mouthPosition aren't all null,
     *             or else if id is negative.
     *
     * @hide
     */
    public Face(Rect bounds, int score, int id,
            Point leftEyePosition, Point rightEyePosition, Point mouthPosition) {
        checkNotNull("bounds", bounds);
        if (score < SCORE_MIN || score > SCORE_MAX) {
            throw new IllegalArgumentException("Confidence out of range");
        } else if (id < 0 && id != ID_UNSUPPORTED) {
            throw new IllegalArgumentException("Id out of range");
        }
        if (id == ID_UNSUPPORTED) {
            checkNull("leftEyePosition", leftEyePosition);
            checkNull("rightEyePosition", rightEyePosition);
            checkNull("mouthPosition", mouthPosition);
        }

        mBounds = bounds;
        mScore = score;
        mId = id;
        mLeftEye = leftEyePosition;
        mRightEye = rightEyePosition;
        mMouth = mouthPosition;
    }


Number 242:
API Relative Path:
src.android.hardware.camera2.params.HighSpeedVideoConfiguration.java-HighSpeedVideoConfiguration(int-int-int-int-int)
Corresponding Source:
/**
     * Create a new {@link HighSpeedVideoConfiguration}.
     *
     * @param width image width, in pixels (positive)
     * @param height image height, in pixels (positive)
     * @param fpsMin minimum frames per second for the configuration (positive)
     * @param fpsMax maximum frames per second for the configuration (larger or equal to 60)
     *
     * @throws IllegalArgumentException
     *              if width/height/fpsMin were not positive or fpsMax less than 60
     *
     * @hide
     */
    public HighSpeedVideoConfiguration(
            final int width, final int height, final int fpsMin, final int fpsMax,
            final int batchSizeMax) {
        if (fpsMax < HIGH_SPEED_MAX_MINIMAL_FPS) {
            throw new IllegalArgumentException("fpsMax must be at least " +
                    HIGH_SPEED_MAX_MINIMAL_FPS);
        }
        mFpsMax = fpsMax;
        mWidth = checkArgumentPositive(width, "width must be positive");
        mHeight = checkArgumentPositive(height, "height must be positive");
        mFpsMin = checkArgumentPositive(fpsMin, "fpsMin must be positive");
        mSize = new Size(mWidth, mHeight);
        mBatchSizeMax = checkArgumentPositive(batchSizeMax, "batchSizeMax must be positive");
        mFpsRange = new Range<Integer>(mFpsMin, mFpsMax);
    }


Number 243:
API Relative Path:
src.android.hardware.camera2.params.LensShadingMap.java-getGainFactor(int-int-int)
Corresponding Source:
/**
     * Get a single color channel gain factor from this lens shading map by its row and column.
     *
     * <p>The rows must be within the range [0, {@link #getRowCount}),
     * the column must be within the range [0, {@link #getColumnCount}),
     * and the color channel must be within the range [0, {@value RggbChannelVector#COUNT}).</p>
     *
     * <p>The channel order is {@code [R, Geven, Godd, B]}, where
     * {@code Geven} is the green channel for the even rows of a Bayer pattern, and
     * {@code Godd} is the odd rows.
     * </p>
     *
     * @param colorChannel color channel from {@code [R, Geven, Godd, B]}
     * @param column within the range [0, {@link #getColumnCount})
     * @param row within the range [0, {@link #getRowCount})
     *
     * @return a gain factor >= {@value #MINIMUM_GAIN_FACTOR}
     *
     * @throws IllegalArgumentException if any of the parameters was out of range
     *
     * @see #RED
     * @see #GREEN_EVEN
     * @see #GREEN_ODD
     * @see #BLUE
     * @see #getRowCount
     * @see #getColumnCount
     */
    public float getGainFactor(final int colorChannel, final int column, final int row) {
        if (colorChannel < 0 || colorChannel > COUNT) {
            throw new IllegalArgumentException("colorChannel out of range");
        } else if (column < 0 || column >= mColumns) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= mRows) {
            throw new IllegalArgumentException("row out of range");
        }

        return mElements[colorChannel + (row * mColumns +  column) * COUNT ];
    }


Number 244:
API Relative Path:
src.android.hardware.camera2.params.LensShadingMap.java-getGainFactor(int-int-int)
Corresponding Source:
/**
     * Get a single color channel gain factor from this lens shading map by its row and column.
     *
     * <p>The rows must be within the range [0, {@link #getRowCount}),
     * the column must be within the range [0, {@link #getColumnCount}),
     * and the color channel must be within the range [0, {@value RggbChannelVector#COUNT}).</p>
     *
     * <p>The channel order is {@code [R, Geven, Godd, B]}, where
     * {@code Geven} is the green channel for the even rows of a Bayer pattern, and
     * {@code Godd} is the odd rows.
     * </p>
     *
     * @param colorChannel color channel from {@code [R, Geven, Godd, B]}
     * @param column within the range [0, {@link #getColumnCount})
     * @param row within the range [0, {@link #getRowCount})
     *
     * @return a gain factor >= {@value #MINIMUM_GAIN_FACTOR}
     *
     * @throws IllegalArgumentException if any of the parameters was out of range
     *
     * @see #RED
     * @see #GREEN_EVEN
     * @see #GREEN_ODD
     * @see #BLUE
     * @see #getRowCount
     * @see #getColumnCount
     */
    public float getGainFactor(final int colorChannel, final int column, final int row) {
        if (colorChannel < 0 || colorChannel > COUNT) {
            throw new IllegalArgumentException("colorChannel out of range");
        } else if (column < 0 || column >= mColumns) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= mRows) {
            throw new IllegalArgumentException("row out of range");
        }

        return mElements[colorChannel + (row * mColumns +  column) * COUNT ];
    }


Number 245:
API Relative Path:
src.android.hardware.camera2.params.LensShadingMap.java-getGainFactor(int-int-int)
Corresponding Source:
/**
     * Get a single color channel gain factor from this lens shading map by its row and column.
     *
     * <p>The rows must be within the range [0, {@link #getRowCount}),
     * the column must be within the range [0, {@link #getColumnCount}),
     * and the color channel must be within the range [0, {@value RggbChannelVector#COUNT}).</p>
     *
     * <p>The channel order is {@code [R, Geven, Godd, B]}, where
     * {@code Geven} is the green channel for the even rows of a Bayer pattern, and
     * {@code Godd} is the odd rows.
     * </p>
     *
     * @param colorChannel color channel from {@code [R, Geven, Godd, B]}
     * @param column within the range [0, {@link #getColumnCount})
     * @param row within the range [0, {@link #getRowCount})
     *
     * @return a gain factor >= {@value #MINIMUM_GAIN_FACTOR}
     *
     * @throws IllegalArgumentException if any of the parameters was out of range
     *
     * @see #RED
     * @see #GREEN_EVEN
     * @see #GREEN_ODD
     * @see #BLUE
     * @see #getRowCount
     * @see #getColumnCount
     */
    public float getGainFactor(final int colorChannel, final int column, final int row) {
        if (colorChannel < 0 || colorChannel > COUNT) {
            throw new IllegalArgumentException("colorChannel out of range");
        } else if (column < 0 || column >= mColumns) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= mRows) {
            throw new IllegalArgumentException("row out of range");
        }

        return mElements[colorChannel + (row * mColumns +  column) * COUNT ];
    }


Number 246:
API Relative Path:
src.android.hardware.camera2.params.LensShadingMap.java-getGainFactorVector(int-int)
Corresponding Source:
/**
     * Get a gain factor vector from this lens shading map by its row and column.
     *
     * <p>The rows must be within the range [0, {@link #getRowCount}),
     * the column must be within the range [0, {@link #getColumnCount}).</p>
     *
     * @param column within the range [0, {@link #getColumnCount})
     * @param row within the range [0, {@link #getRowCount})
     *
     * @return an {@link RggbChannelVector} where each gain factor >= {@value #MINIMUM_GAIN_FACTOR}
     *
     * @throws IllegalArgumentException if any of the parameters was out of range
     *
     * @see #getRowCount
     * @see #getColumnCount
     */
    public RggbChannelVector getGainFactorVector(final int column, final int row) {
        if (column < 0 || column >= mColumns) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= mRows) {
            throw new IllegalArgumentException("row out of range");
        }

        final int offset = (row * mColumns +  column) * COUNT;

        final float red =
                mElements[RED + offset];
        final float greenEven =
                mElements[GREEN_EVEN + offset];
        final float greenOdd =
                mElements[GREEN_ODD + offset];
        final float blue =
                mElements[BLUE + offset];

        return new RggbChannelVector(red, greenEven, greenOdd, blue);
    }


Number 247:
API Relative Path:
src.android.hardware.camera2.params.LensShadingMap.java-getGainFactorVector(int-int)
Corresponding Source:
/**
     * Get a gain factor vector from this lens shading map by its row and column.
     *
     * <p>The rows must be within the range [0, {@link #getRowCount}),
     * the column must be within the range [0, {@link #getColumnCount}).</p>
     *
     * @param column within the range [0, {@link #getColumnCount})
     * @param row within the range [0, {@link #getRowCount})
     *
     * @return an {@link RggbChannelVector} where each gain factor >= {@value #MINIMUM_GAIN_FACTOR}
     *
     * @throws IllegalArgumentException if any of the parameters was out of range
     *
     * @see #getRowCount
     * @see #getColumnCount
     */
    public RggbChannelVector getGainFactorVector(final int column, final int row) {
        if (column < 0 || column >= mColumns) {
            throw new IllegalArgumentException("column out of range");
        } else if (row < 0 || row >= mRows) {
            throw new IllegalArgumentException("row out of range");
        }

        final int offset = (row * mColumns +  column) * COUNT;

        final float red =
                mElements[RED + offset];
        final float greenEven =
                mElements[GREEN_EVEN + offset];
        final float greenOdd =
                mElements[GREEN_ODD + offset];
        final float blue =
                mElements[BLUE + offset];

        return new RggbChannelVector(red, greenEven, greenOdd, blue);
    }


Number 248:
API Relative Path:
src.android.hardware.camera2.params.OutputConfiguration.java-OutputConfiguration(OutputConfiguration)
Corresponding Source:
/**
     * Create a new {@link OutputConfiguration} instance with another {@link OutputConfiguration}
     * instance.
     *
     * @param other Another {@link OutputConfiguration} instance to be copied.
     *
     * @hide
     */
    public OutputConfiguration(@NonNull OutputConfiguration other) {
        if (other == null) {
            throw new IllegalArgumentException("OutputConfiguration shouldn't be null");
        }

        this.mSurface = other.mSurface;
        this.mRotation = other.mRotation;
        this.mSurfaceGroupId = other.mSurfaceGroupId;
        this.mConfiguredDataspace = other.mConfiguredDataspace;
        this.mConfiguredFormat = other.mConfiguredFormat;
        this.mConfiguredSize = other.mConfiguredSize;
        this.mConfiguredGenerationId = other.mConfiguredGenerationId;
    }


Number 249:
API Relative Path:
src.android.hardware.camera2.params.RggbChannelVector.java-copyTo(float[]-int)
Corresponding Source:
/**
     * Copy the vector into the destination in the order {@code [R, Geven, Godd, B]}.
     *
     * @param destination
     *          an array big enough to hold at least {@value #COUNT} elements after the
     *          {@code offset}
     * @param offset
     *          a non-negative offset into the array
     *
     * @throws NullPointerException
     *          If {@code destination} was {@code null}
     * @throws ArrayIndexOutOfBoundsException
     *          If there's not enough room to write the elements at the specified destination and
     *          offset.
     */
    public void copyTo(final float[] destination, final int offset) {
        checkNotNull(destination, "destination must not be null");
        if (destination.length - offset < COUNT) {
            throw new ArrayIndexOutOfBoundsException("destination too small to fit elements");
        }

        destination[offset + RED] = mRed;
        destination[offset + GREEN_EVEN] = mGreenEven;
        destination[offset + GREEN_ODD] = mGreenOdd;
        destination[offset + BLUE] = mBlue;
    }


Number 250:
API Relative Path:
src.android.hardware.camera2.params.RggbChannelVector.java-getComponent(int)
Corresponding Source:
/**
     * Get the component by the color channel index.
     *
     * <p>{@code colorChannel} must be one of {@link #RED}, {@link #GREEN_EVEN}, {@link #GREEN_ODD},
     * {@link #BLUE}.</p>
     *
     * @param colorChannel greater or equal to {@code 0} and less than {@link #COUNT}
     * @return a floating point value (guaranteed to be finite)
     *
     * @throws IllegalArgumentException if {@code colorChannel} was out of range
     */
    public float getComponent(final int colorChannel) {
        if (colorChannel < 0 || colorChannel >= COUNT) {
            throw new IllegalArgumentException("Color channel out of range");
        }

        switch (colorChannel) {
            case RED:
                return mRed;
            case GREEN_EVEN:
                return mGreenEven;
            case GREEN_ODD:
                return mGreenOdd;
            case BLUE:
                return mBlue;
            default:
                throw new AssertionError("Unhandled case " + colorChannel);
        }
    }


Number 251:
API Relative Path:
src.android.hardware.camera2.params.StreamConfigurationMap.java-imageFormatToInternal(int[])
Corresponding Source:
/**
     * Convert image formats from public to internal formats (in-place).
     *
     * @param formats an array of image formats
     * @return {@code formats}
     *
     * @see #imageFormatToInternal
     *
     * @hide
     */
    public static int[] imageFormatToInternal(int[] formats) {
        if (formats == null) {
            return null;
        }

        for (int i = 0; i < formats.length; ++i) {
            formats[i] = imageFormatToInternal(formats[i]);
        }

        return formats;
    }


Number 252:
API Relative Path:
src.android.hardware.camera2.params.StreamConfigurationMap.java-imageFormatToPublic(int[])
Corresponding Source:
/**
     * Convert image formats from internal to public formats (in-place).
     *
     * @param formats an array of image formats
     * @return {@code formats}
     *
     * @see #imageFormatToPublic
     */
    static int[] imageFormatToPublic(int[] formats) {
        if (formats == null) {
            return null;
        }

        for (int i = 0; i < formats.length; ++i) {
            formats[i] = imageFormatToPublic(formats[i]);
        }

        return formats;
    }


Number 253:
API Relative Path:
src.android.hardware.camera2.params.StreamConfigurationMap.java-StreamConfigurationMap(StreamConfiguration[]-StreamConfigurationDuration[]-StreamConfigurationDuration[]-StreamConfiguration[]-StreamConfigurationDuration[]-StreamConfigurationDuration[]-HighSpeedVideoConfiguration[]-ReprocessFormatsMap-boolean)
Corresponding Source:
/**
     * Create a new {@link StreamConfigurationMap}.
     *
     * <p>The array parameters ownership is passed to this object after creation; do not
     * write to them after this constructor is invoked.</p>
     *
     * @param configurations a non-{@code null} array of {@link StreamConfiguration}
     * @param minFrameDurations a non-{@code null} array of {@link StreamConfigurationDuration}
     * @param stallDurations a non-{@code null} array of {@link StreamConfigurationDuration}
     * @param highSpeedVideoConfigurations an array of {@link HighSpeedVideoConfiguration}, null if
     *        camera device does not support high speed video recording
     * @param listHighResolution a flag indicating whether the device supports BURST_CAPTURE
     *        and thus needs a separate list of slow high-resolution output sizes
     * @throws NullPointerException if any of the arguments except highSpeedVideoConfigurations
     *         were {@code null} or any subelements were {@code null}
     *
     * @hide
     */
    public StreamConfigurationMap(
            StreamConfiguration[] configurations,
            StreamConfigurationDuration[] minFrameDurations,
            StreamConfigurationDuration[] stallDurations,
            StreamConfiguration[] depthConfigurations,
            StreamConfigurationDuration[] depthMinFrameDurations,
            StreamConfigurationDuration[] depthStallDurations,
            HighSpeedVideoConfiguration[] highSpeedVideoConfigurations,
            ReprocessFormatsMap inputOutputFormatsMap,
            boolean listHighResolution) {

        if (configurations == null) {
            // If no color configurations exist, ensure depth ones do
            checkArrayElementsNotNull(depthConfigurations, "depthConfigurations");
            mConfigurations = new StreamConfiguration[0];
            mMinFrameDurations = new StreamConfigurationDuration[0];
            mStallDurations = new StreamConfigurationDuration[0];
        } else {
            mConfigurations = checkArrayElementsNotNull(configurations, "configurations");
            mMinFrameDurations = checkArrayElementsNotNull(minFrameDurations, "minFrameDurations");
            mStallDurations = checkArrayElementsNotNull(stallDurations, "stallDurations");
        }

        mListHighResolution = listHighResolution;

        if (depthConfigurations == null) {
            mDepthConfigurations = new StreamConfiguration[0];
            mDepthMinFrameDurations = new StreamConfigurationDuration[0];
            mDepthStallDurations = new StreamConfigurationDuration[0];
        } else {
            mDepthConfigurations = checkArrayElementsNotNull(depthConfigurations,
                    "depthConfigurations");
            mDepthMinFrameDurations = checkArrayElementsNotNull(depthMinFrameDurations,
                    "depthMinFrameDurations");
            mDepthStallDurations = checkArrayElementsNotNull(depthStallDurations,
                    "depthStallDurations");
        }

        if (highSpeedVideoConfigurations == null) {
            mHighSpeedVideoConfigurations = new HighSpeedVideoConfiguration[0];
        } else {
            mHighSpeedVideoConfigurations = checkArrayElementsNotNull(
                    highSpeedVideoConfigurations, "highSpeedVideoConfigurations");
        }

        // For each format, track how many sizes there are available to configure
        for (StreamConfiguration config : mConfigurations) {
            int fmt = config.getFormat();
            SparseIntArray map = null;
            if (config.isOutput()) {
                mAllOutputFormats.put(fmt, mAllOutputFormats.get(fmt) + 1);
                long duration = 0;
                if (mListHighResolution) {
                    for (StreamConfigurationDuration configurationDuration : mMinFrameDurations) {
                        if (configurationDuration.getFormat() == fmt &&
                                configurationDuration.getWidth() == config.getSize().getWidth() &&
                                configurationDuration.getHeight() == config.getSize().getHeight()) {
                            duration = configurationDuration.getDuration();
                            break;
                        }
                    }
                }
                map = duration <= DURATION_20FPS_NS ?
                        mOutputFormats : mHighResOutputFormats;
            } else {
                map = mInputFormats;
            }
            map.put(fmt, map.get(fmt) + 1);
        }

        // For each depth format, track how many sizes there are available to configure
        for (StreamConfiguration config : mDepthConfigurations) {
            if (!config.isOutput()) {
                // Ignoring input depth configs
                continue;
            }

            mDepthOutputFormats.put(config.getFormat(),
                    mDepthOutputFormats.get(config.getFormat()) + 1);
        }

        if (configurations != null &&
                mOutputFormats.indexOfKey(HAL_PIXEL_FORMAT_IMPLEMENTATION_DEFINED) < 0) {
            throw new AssertionError(
                    "At least one stream configuration for IMPLEMENTATION_DEFINED must exist");
        }

        // For each Size/FPS range, track how many FPS range/Size there are available
        for (HighSpeedVideoConfiguration config : mHighSpeedVideoConfigurations) {
            Size size = config.getSize();
            Range<Integer> fpsRange = config.getFpsRange();
            Integer fpsRangeCount = mHighSpeedVideoSizeMap.get(size);
            if (fpsRangeCount == null) {
                fpsRangeCount = 0;
            }
            mHighSpeedVideoSizeMap.put(size, fpsRangeCount + 1);
            Integer sizeCount = mHighSpeedVideoFpsRangeMap.get(fpsRange);
            if (sizeCount == null) {
                sizeCount = 0;
            }
            mHighSpeedVideoFpsRangeMap.put(fpsRange, sizeCount + 1);
        }

        mInputOutputFormatsMap = inputOutputFormatsMap;
    }


Number 254:
API Relative Path:
src.android.hardware.camera2.params.TonemapCurve.java-getPoint(int-int)
Corresponding Source:
/**
     * Get the point for a color channel at a specified index.
     *
     * <p>The index must be at least 0 but no greater than {@link #getPointCount(int)} for
     * that {@code colorChannel}.</p>
     *
     * <p>All returned coordinates in the point are between the range of
     * [{@value #LEVEL_BLACK}, {@value #LEVEL_WHITE}].</p>
     *
     * @param colorChannel {@link #CHANNEL_RED}, {@link #CHANNEL_GREEN}, or {@link #CHANNEL_BLUE}
     * @param index at least 0 but no greater than {@code getPointCount(colorChannel)}
     * @return the {@code (Pin, Pout)} pair mapping the tone for that index
     *
     * @throws IllegalArgumentException if {@code colorChannel} or {@code index} was out of range
     *
     * @see #LEVEL_BLACK
     * @see #LEVEL_WHITE
     */
    public PointF getPoint(int colorChannel, int index) {
        checkArgumentColorChannel(colorChannel);
        if (index < 0 || index >= getPointCount(colorChannel)) {
            throw new IllegalArgumentException("index out of range");
        }

        final float[] curve = getCurve(colorChannel);

        final float pIn = curve[index * POINT_SIZE + OFFSET_POINT_IN];
        final float pOut = curve[index * POINT_SIZE + OFFSET_POINT_OUT];

        return new PointF(pIn, pOut);
    }


Number 255:
API Relative Path:
src.android.hardware.camera2.utils.ArrayUtils.java-convertStringListToIntArray(List-String[]-int[])
Corresponding Source:
/**
     * Create an {@code int[]} from the {@code List<>} by using {@code convertFrom} and
     * {@code convertTo} as a one-to-one map (via the index).
     *
     * <p>Strings not appearing in {@code convertFrom} are ignored (with a logged warning);
     * strings appearing in {@code convertFrom} but not {@code convertTo} are silently
     * dropped.</p>
     *
     * @param list Source list of strings
     * @param convertFrom Conversion list of strings
     * @param convertTo Conversion list of ints
     * @return An array of ints where the values correspond to the ones in {@code convertTo}
     *         or {@code null} if {@code list} was {@code null}
     */
    public static int[] convertStringListToIntArray(
            List<String> list, String[] convertFrom, int[] convertTo) {
        if (list == null) {
            return null;
        }

        List<Integer> convertedList = convertStringListToIntList(list, convertFrom, convertTo);

        int[] returnArray = new int[convertedList.size()];
        for (int i = 0; i < returnArray.length; ++i) {
            returnArray[i] = convertedList.get(i);
        }

        return returnArray;
    }


Number 256:
API Relative Path:
src.android.hardware.camera2.utils.ArrayUtils.java-convertStringListToIntList(List-String[]-int[])
Corresponding Source:
/**
     * Create an {@code List<Integer>} from the {@code List<>} by using {@code convertFrom} and
     * {@code convertTo} as a one-to-one map (via the index).
     *
     * <p>Strings not appearing in {@code convertFrom} are ignored (with a logged warning);
     * strings appearing in {@code convertFrom} but not {@code convertTo} are silently
     * dropped.</p>
     *
     * @param list Source list of strings
     * @param convertFrom Conversion list of strings
     * @param convertTo Conversion list of ints
     * @return A list of ints where the values correspond to the ones in {@code convertTo}
     *         or {@code null} if {@code list} was {@code null}
     */
    public static List<Integer> convertStringListToIntList(
            List<String> list, String[] convertFrom, int[] convertTo) {
        if (list == null) {
            return null;
        }

        List<Integer> convertedList = new ArrayList<>(list.size());

        for (String str : list) {
            int strIndex = getArrayIndex(convertFrom, str);

            // Guard against unexpected values
            if (strIndex < 0) {
                if (DEBUG) Log.v(TAG, "Ignoring invalid value " + str);
                continue;
            }

            // Ignore values we can't map into (intentional)
            if (strIndex < convertTo.length) {
                convertedList.add(convertTo[strIndex]);
            }
        }

        return convertedList;
    }


Number 257:
API Relative Path:
src.android.hardware.camera2.utils.ArrayUtils.java-toIntArray(List)
Corresponding Source:
/**
     * Convert the list of integers in {@code list} to an {@code int} array.
     *
     * <p>Every element in {@code list} must be non-{@code null}.</p>
     *
     * @param list a list of non-{@code null} integers
     *
     * @return a new int array containing all the elements from {@code list}
     *
     * @throws NullPointerException if any of the elements in {@code list} were {@code null}
     */
    public static int[] toIntArray(List<Integer> list) {
        if (list == null) {
            return null;
        }

        int[] arr = new int[list.size()];
        int i = 0;
        for (int elem : list) {
            arr[i] = elem;
            i++;
        }

        return arr;
    }


Number 258:
API Relative Path:
src.android.hardware.camera2.utils.ListUtils.java-listSelectFirstFrom(List-T[])
Corresponding Source:
/**
     * Return the first item from {@code choices} that is contained in the {@code list}.
     *
     * <p>Choices with an index closer to 0 get higher priority. If none of the {@code choices}
     * are in the {@code list}, then {@code null} is returned.
     *
     * @param list a list of objects which may or may not contain one or more of the choices
     * @param choices an array of objects which should be used to select an item from
     *
     * @return the first item from {@code choices} contained in {@code list}, otherwise {@code null}
     */
    public static <T> T listSelectFirstFrom(List<T> list, T[] choices) {
        if (list == null) {
            return null;
        }

        for (T choice : choices) {
            if (list.contains(choice)) {
                return choice;
            }
        }

        return null;
    }


Number 259:
API Relative Path:
src.android.hardware.camera2.utils.ListUtils.java-listToString(List)
Corresponding Source:
/**
     * Return a human-readable representation of a list (non-recursively).
     */
    public static <T> String listToString(List<T> list) {
        if (list == null) {
            return null;
        }

        StringBuilder sb = new StringBuilder();
        sb.append('[');

        int size = list.size();
        int i = 0;
        for (T elem : list) {
            sb.append(elem);

            if (i != size - 1) {
                sb.append(',');
            }
            i++;
        }
        sb.append(']');

        return sb.toString();
    }


Number 260:
API Relative Path:
src.android.hardware.camera2.utils.SurfaceUtils.java-checkConstrainedHighSpeedSurfaces(Collection-Range-StreamConfigurationMap)
Corresponding Source:
/**
     * Verify that that the surfaces are valid for high-speed recording mode,
     * and that the FPS range is supported
     *
     * @param surfaces the surfaces to verify as valid in terms of size and format
     * @param fpsRange the target high-speed FPS range to validate
     * @param config The stream configuration map for the device in question
     */
    public static void checkConstrainedHighSpeedSurfaces(Collection<Surface> surfaces,
            Range<Integer> fpsRange, StreamConfigurationMap config) {
        if (surfaces == null || surfaces.size() == 0 || surfaces.size() > 2) {
            throw new IllegalArgumentException("Output target surface list must not be null and"
                    + " the size must be 1 or 2");
        }

        List<Size> highSpeedSizes = null;
        if (fpsRange == null) {
            highSpeedSizes = Arrays.asList(config.getHighSpeedVideoSizes());
        } else {
            // Check the FPS range first if provided
            Range<Integer>[] highSpeedFpsRanges = config.getHighSpeedVideoFpsRanges();
            if(!Arrays.asList(highSpeedFpsRanges).contains(fpsRange)) {
                throw new IllegalArgumentException("Fps range " + fpsRange.toString() + " in the"
                        + " request is not a supported high speed fps range " +
                        Arrays.toString(highSpeedFpsRanges));
            }
            highSpeedSizes = Arrays.asList(config.getHighSpeedVideoSizesFor(fpsRange));
        }

        for (Surface surface : surfaces) {
            checkHighSpeedSurfaceFormat(surface);

            // Surface size must be supported high speed sizes.
            Size surfaceSize = SurfaceUtils.getSurfaceSize(surface);
            if (!highSpeedSizes.contains(surfaceSize)) {
                throw new IllegalArgumentException("Surface size " + surfaceSize.toString() + " is"
                        + " not part of the high speed supported size list " +
                        Arrays.toString(highSpeedSizes.toArray()));
            }
            // Each output surface must be either preview surface or recording surface.
            if (!SurfaceUtils.isSurfaceForPreview(surface) &&
                    !SurfaceUtils.isSurfaceForHwVideoEncoder(surface)) {
                throw new IllegalArgumentException("This output surface is neither preview nor "
                        + "hardware video encoding surface");
            }
            if (SurfaceUtils.isSurfaceForPreview(surface) &&
                    SurfaceUtils.isSurfaceForHwVideoEncoder(surface)) {
                throw new IllegalArgumentException("This output surface can not be both preview"
                        + " and hardware video encoding surface");
            }
        }

        // For 2 output surface case, they shouldn't be same type.
        if (surfaces.size() == 2) {
            // Up to here, each surface can only be either preview or recording.
            Iterator<Surface> iterator = surfaces.iterator();
            boolean isFirstSurfacePreview =
                    SurfaceUtils.isSurfaceForPreview(iterator.next());
            boolean isSecondSurfacePreview =
                    SurfaceUtils.isSurfaceForPreview(iterator.next());
            if (isFirstSurfacePreview == isSecondSurfacePreview) {
                throw new IllegalArgumentException("The 2 output surfaces must have different"
                        + " type");
            }
        }
    }


Number 261:
API Relative Path:
src.android.hardware.fingerprint.FingerprintManager.java-authenticate(CryptoObject-CancellationSignal-int-AuthenticationCallback-Handler-int)
Corresponding Source:
/**
     * Per-user version
     * @hide
     */
    @RequiresPermission(USE_FINGERPRINT)
    public void authenticate(@Nullable CryptoObject crypto, @Nullable CancellationSignal cancel,
            int flags, @NonNull AuthenticationCallback callback, Handler handler, int userId) {
        if (callback == null) {
            throw new IllegalArgumentException("Must supply an authentication callback");
        }

        if (cancel != null) {
            if (cancel.isCanceled()) {
                Log.w(TAG, "authentication already canceled");
                return;
            } else {
                cancel.setOnCancelListener(new OnAuthenticationCancelListener(crypto));
            }
        }

        if (mService != null) try {
            useHandler(handler);
            mAuthenticationCallback = callback;
            mCryptoObject = crypto;
            long sessionId = crypto != null ? crypto.getOpId() : 0;
            mService.authenticate(mToken, sessionId, userId, mServiceReceiver, flags,
                    mContext.getOpPackageName());
        } catch (RemoteException e) {
            Log.w(TAG, "Remote exception while authenticating: ", e);
            if (callback != null) {
                // Though this may not be a hardware issue, it will cause apps to give up or try
                // again later.
                callback.onAuthenticationError(FINGERPRINT_ERROR_HW_UNAVAILABLE,
                        getErrorString(FINGERPRINT_ERROR_HW_UNAVAILABLE));
            }
        }
    }


Number 262:
API Relative Path:
src.android.hardware.fingerprint.FingerprintManager.java-enroll(byte[]-CancellationSignal-int-int-EnrollmentCallback)
Corresponding Source:
/**
     * Request fingerprint enrollment. This call warms up the fingerprint hardware
     * and starts scanning for fingerprints. Progress will be indicated by callbacks to the
     * {@link EnrollmentCallback} object. It terminates when
     * {@link EnrollmentCallback#onEnrollmentError(int, CharSequence)} or
     * {@link EnrollmentCallback#onEnrollmentProgress(int) is called with remaining == 0, at
     * which point the object is no longer valid. The operation can be canceled by using the
     * provided cancel object.
     * @param token a unique token provided by a recent creation or verification of device
     * credentials (e.g. pin, pattern or password).
     * @param cancel an object that can be used to cancel enrollment
     * @param flags optional flags
     * @param userId the user to whom this fingerprint will belong to
     * @param callback an object to receive enrollment events
     * @hide
     */
    @RequiresPermission(MANAGE_FINGERPRINT)
    public void enroll(byte [] token, CancellationSignal cancel, int flags,
            int userId, EnrollmentCallback callback) {
        if (userId == UserHandle.USER_CURRENT) {
            userId = getCurrentUserId();
        }
        if (callback == null) {
            throw new IllegalArgumentException("Must supply an enrollment callback");
        }

        if (cancel != null) {
            if (cancel.isCanceled()) {
                Log.w(TAG, "enrollment already canceled");
                return;
            } else {
                cancel.setOnCancelListener(new OnEnrollCancelListener());
            }
        }

        if (mService != null) try {
            mEnrollmentCallback = callback;
            mService.enroll(mToken, token, userId, mServiceReceiver, flags,
                    mContext.getOpPackageName());
        } catch (RemoteException e) {
            Log.w(TAG, "Remote exception in enroll: ", e);
            if (callback != null) {
                // Though this may not be a hardware issue, it will cause apps to give up or try
                // again later.
                callback.onEnrollmentError(FINGERPRINT_ERROR_HW_UNAVAILABLE,
                        getErrorString(FINGERPRINT_ERROR_HW_UNAVAILABLE));
            }
        }
    }


Number 263:
API Relative Path:
src.android.hardware.hdmi.HdmiClient.java-setVendorCommandListener(VendorCommandListener)
Corresponding Source:
/**
     * Sets a listener used to receive incoming vendor-specific command.
     *
     * @param listener listener object
     */
    public void setVendorCommandListener(@NonNull VendorCommandListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener cannot be null");
        }
        if (mIHdmiVendorCommandListener != null) {
            throw new IllegalStateException("listener was already set");
        }
        try {
            IHdmiVendorCommandListener wrappedListener = getListenerWrapper(listener);
            mService.addVendorCommandListener(wrappedListener, getDeviceType());
            mIHdmiVendorCommandListener = wrappedListener;
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set vendor command listener: ", e);
        }
    }


Number 264:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofAnalogue(int-int-int)
Corresponding Source:
/**
     * Creates {@link AnalogueServiceSource} of analogue service.
     *
     * @param broadcastType
     * @param frequency
     * @param broadcastSystem
     * @hide
     */
    @Nullable
    public static AnalogueServiceSource ofAnalogue(int broadcastType, int frequency,
            int broadcastSystem){
        if (broadcastType < ANALOGUE_BROADCAST_TYPE_CABLE
                || broadcastType > ANALOGUE_BROADCAST_TYPE_TERRESTRIAL) {
            Log.w(TAG, "Invalid Broadcast type:" + broadcastType);
            throw new IllegalArgumentException("Invalid Broadcast type:" + broadcastType);
        }
        if (frequency < 0 || frequency > 0xFFFF) {
            Log.w(TAG, "Invalid frequency value[0x0000-0xFFFF]:" + frequency);
            throw new IllegalArgumentException(
                    "Invalid frequency value[0x0000-0xFFFF]:" + frequency);
        }
        if (broadcastSystem < BROADCAST_SYSTEM_PAL_BG
                || broadcastSystem > BROADCAST_SYSTEM_PAL_OTHER_SYSTEM) {

            Log.w(TAG, "Invalid Broadcast system:" + broadcastSystem);
            throw new IllegalArgumentException(
                    "Invalid Broadcast system:" + broadcastSystem);
        }

        return new AnalogueServiceSource(broadcastType, frequency, broadcastSystem);
    }


Number 265:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofAnalogue(int-int-int)
Corresponding Source:
/**
     * Creates {@link AnalogueServiceSource} of analogue service.
     *
     * @param broadcastType
     * @param frequency
     * @param broadcastSystem
     * @hide
     */
    @Nullable
    public static AnalogueServiceSource ofAnalogue(int broadcastType, int frequency,
            int broadcastSystem){
        if (broadcastType < ANALOGUE_BROADCAST_TYPE_CABLE
                || broadcastType > ANALOGUE_BROADCAST_TYPE_TERRESTRIAL) {
            Log.w(TAG, "Invalid Broadcast type:" + broadcastType);
            throw new IllegalArgumentException("Invalid Broadcast type:" + broadcastType);
        }
        if (frequency < 0 || frequency > 0xFFFF) {
            Log.w(TAG, "Invalid frequency value[0x0000-0xFFFF]:" + frequency);
            throw new IllegalArgumentException(
                    "Invalid frequency value[0x0000-0xFFFF]:" + frequency);
        }
        if (broadcastSystem < BROADCAST_SYSTEM_PAL_BG
                || broadcastSystem > BROADCAST_SYSTEM_PAL_OTHER_SYSTEM) {

            Log.w(TAG, "Invalid Broadcast system:" + broadcastSystem);
            throw new IllegalArgumentException(
                    "Invalid Broadcast system:" + broadcastSystem);
        }

        return new AnalogueServiceSource(broadcastType, frequency, broadcastSystem);
    }


Number 266:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofAnalogue(int-int-int)
Corresponding Source:
/**
     * Creates {@link AnalogueServiceSource} of analogue service.
     *
     * @param broadcastType
     * @param frequency
     * @param broadcastSystem
     * @hide
     */
    @Nullable
    public static AnalogueServiceSource ofAnalogue(int broadcastType, int frequency,
            int broadcastSystem){
        if (broadcastType < ANALOGUE_BROADCAST_TYPE_CABLE
                || broadcastType > ANALOGUE_BROADCAST_TYPE_TERRESTRIAL) {
            Log.w(TAG, "Invalid Broadcast type:" + broadcastType);
            throw new IllegalArgumentException("Invalid Broadcast type:" + broadcastType);
        }
        if (frequency < 0 || frequency > 0xFFFF) {
            Log.w(TAG, "Invalid frequency value[0x0000-0xFFFF]:" + frequency);
            throw new IllegalArgumentException(
                    "Invalid frequency value[0x0000-0xFFFF]:" + frequency);
        }
        if (broadcastSystem < BROADCAST_SYSTEM_PAL_BG
                || broadcastSystem > BROADCAST_SYSTEM_PAL_OTHER_SYSTEM) {

            Log.w(TAG, "Invalid Broadcast system:" + broadcastSystem);
            throw new IllegalArgumentException(
                    "Invalid Broadcast system:" + broadcastSystem);
        }

        return new AnalogueServiceSource(broadcastType, frequency, broadcastSystem);
    }


Number 267:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofArib(int-AribData)
Corresponding Source:
/**
     * Creates {@link DigitalServiceSource} of ARIB type.
     *
     * @param aribType ARIB type. It should be one of
     *            <ul>
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB_BS}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB_CS}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB_T}
     *            </ul>
     * @hide
     */
    @Nullable
    public static DigitalServiceSource ofArib(int aribType, AribData data) {
        if (data == null) {
            throw new IllegalArgumentException("data should not be null.");
        }
        switch (aribType) {
            case DIGITAL_BROADCAST_TYPE_ARIB:
            case DIGITAL_BROADCAST_TYPE_ARIB_BS:
            case DIGITAL_BROADCAST_TYPE_ARIB_CS:
            case DIGITAL_BROADCAST_TYPE_ARIB_T:
                return new DigitalServiceSource(
                        DigitalServiceSource.DIGITAL_SERVICE_IDENTIFIED_BY_DIGITAL_ID,
                        aribType, data);
            default:
                Log.w(TAG, "Invalid ARIB type:" + aribType);
                throw new IllegalArgumentException("type should not be null.");
        }
    }


Number 268:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofAtsc(int-AtscData)
Corresponding Source:
/**
     * Creates {@link DigitalServiceSource} of ATSC type.
     *
     * @param atscType ATSC type. It should be one of
     *            <ul>
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC_CABLE}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC_SATELLITE}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC_TERRESTRIAL}
     *            </ul>
     * @hide
     */
    @Nullable
    public static DigitalServiceSource ofAtsc(int atscType, AtscData data) {
        if (data == null) {
            throw new IllegalArgumentException("data should not be null.");
        }
        switch (atscType) {
            case DIGITAL_BROADCAST_TYPE_ATSC:
            case DIGITAL_BROADCAST_TYPE_ATSC_CABLE:
            case DIGITAL_BROADCAST_TYPE_ATSC_SATELLITE:
            case DIGITAL_BROADCAST_TYPE_ATSC_TERRESTRIAL:
                return new DigitalServiceSource(
                        DigitalServiceSource.DIGITAL_SERVICE_IDENTIFIED_BY_DIGITAL_ID,
                        atscType, data);
            default:
                Log.w(TAG, "Invalid ATSC type:" + atscType);
                throw new IllegalArgumentException("Invalid ATSC type:" + atscType);
        }
    }


Number 269:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofDigitalChannelId(int-DigitalChannelData)
Corresponding Source:
/**
     * Creates {@link DigitalServiceSource} with channel type.
     *
     * @param broadcastSystem digital broadcast system. It should be one of
     *            <ul>
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB_BS}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB_CS}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ARIB_T}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC_CABLE}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC_SATELLITE}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_ATSC_TERRESTRIAL}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_C}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_S}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_S2}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_T}
     *            </ul>
     * @hide
     */
    public static DigitalServiceSource ofDigitalChannelId(int broadcastSystem,
            DigitalChannelData data) {
        if (data == null) {
            throw new IllegalArgumentException("data should not be null.");
        }
        switch (broadcastSystem) {
            case DIGITAL_BROADCAST_TYPE_ARIB:
            case DIGITAL_BROADCAST_TYPE_ATSC:
            case DIGITAL_BROADCAST_TYPE_DVB:
            case DIGITAL_BROADCAST_TYPE_ARIB_BS:
            case DIGITAL_BROADCAST_TYPE_ARIB_CS:
            case DIGITAL_BROADCAST_TYPE_ARIB_T:
            case DIGITAL_BROADCAST_TYPE_ATSC_CABLE:
            case DIGITAL_BROADCAST_TYPE_ATSC_SATELLITE:
            case DIGITAL_BROADCAST_TYPE_ATSC_TERRESTRIAL:
            case DIGITAL_BROADCAST_TYPE_DVB_C:
            case DIGITAL_BROADCAST_TYPE_DVB_S:
            case DIGITAL_BROADCAST_TYPE_DVB_S2:
            case DIGITAL_BROADCAST_TYPE_DVB_T:
                return new DigitalServiceSource(
                        DigitalServiceSource.DIGITAL_SERVICE_IDENTIFIED_BY_CHANNEL,
                        broadcastSystem,
                        data);
            default:
                Log.w(TAG, "Invalid broadcast type:" + broadcastSystem);
                throw new IllegalArgumentException(
                        "Invalid broadcast system value:" + broadcastSystem);
        }
    }


Number 270:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofDvb(int-DvbData)
Corresponding Source:
/**
     * Creates {@link DigitalServiceSource} of ATSC type.
     *
     * @param dvbType DVB type. It should be one of
     *            <ul>
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_C}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_S}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_S2}
     *            <li>{@link #DIGITAL_BROADCAST_TYPE_DVB_T}
     *            </ul>
     * @hide
     */
    @Nullable
    public static DigitalServiceSource ofDvb(int dvbType, DvbData data) {
        if (data == null) {
            throw new IllegalArgumentException("data should not be null.");
        }
        switch (dvbType) {
            case DIGITAL_BROADCAST_TYPE_DVB:
            case DIGITAL_BROADCAST_TYPE_DVB_C:
            case DIGITAL_BROADCAST_TYPE_DVB_S:
            case DIGITAL_BROADCAST_TYPE_DVB_S2:
            case DIGITAL_BROADCAST_TYPE_DVB_T:
                return new DigitalServiceSource(
                        DigitalServiceSource.DIGITAL_SERVICE_IDENTIFIED_BY_DIGITAL_ID,
                        dvbType, data);
            default:
                Log.w(TAG, "Invalid DVB type:" + dvbType);
                throw new IllegalArgumentException("Invalid DVB type:" + dvbType);
        }
    }


Number 271:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofExternalPhysicalAddress(int)
Corresponding Source:
// ---------------------------------------------------------------------------------------------
    // ---- External physical address --------------------------------------------------------------
    // ---------------------------------------------------------------------------------------------
    /**
     * Creates {@link ExternalPhysicalAddress} of external physical address.
     *
     * @param physicalAddress
     * @hide
     */
    public static ExternalPhysicalAddress ofExternalPhysicalAddress(int physicalAddress) {
        if ((physicalAddress & ~0xFFFF) != 0) {
            Log.w(TAG, "Invalid physical address:" + physicalAddress);
            throw new IllegalArgumentException("Invalid physical address:" + physicalAddress);
        }

        return new ExternalPhysicalAddress(physicalAddress);
    }


Number 272:
API Relative Path:
src.android.hardware.hdmi.HdmiRecordSources.java-ofExternalPlug(int)
Corresponding Source:
// ---------------------------------------------------------------------------------------------
    // ---- External plug data ---------------------------------------------------------------------
    // ---------------------------------------------------------------------------------------------
    /**
     * Creates {@link ExternalPlugData} of external plug type.
     *
     * @param plugNumber plug number. It should be in range of [1, 255]
     * @hide
     */
    public static ExternalPlugData ofExternalPlug(int plugNumber) {
        if (plugNumber < 1 || plugNumber > 255) {
            Log.w(TAG, "Invalid plug number[1-255]" + plugNumber);
            throw new IllegalArgumentException("Invalid plug number[1-255]" + plugNumber);
        }
        return new ExternalPlugData(plugNumber);
    }


Number 273:
API Relative Path:
src.android.hardware.hdmi.HdmiTimerRecordSources.java-timerInfoOf(int-int-Time-Duration-int)
Corresponding Source:
/**
     * Creates {@link TimerInfo} with the given information.
     *
     * @param dayOfMonth day of month
     * @param monthOfYear month of year
     * @param startTime start time in {@link Time}
     * @param duration duration in {@link Duration}
     * @param recordingSequence recording sequence. Use RECORDING_SEQUENCE_REPEAT_ONCE_ONLY for no
     *            repeat. Otherwise use combination of {@link #RECORDING_SEQUENCE_REPEAT_SUNDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_MONDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_TUESDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_WEDNESDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_THURSDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_FRIDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_SATUREDAY}.
     * @return {@link TimerInfo}.
     * @throws IllegalArgumentException if input value is invalid
     */
    public static TimerInfo timerInfoOf(int dayOfMonth, int monthOfYear, Time startTime,
            Duration duration, int recordingSequence) {
        if (dayOfMonth < 0 || dayOfMonth > 31) {
            throw new IllegalArgumentException(
                    "Day of month should be in range of [0, 31]:" + dayOfMonth);
        }
        if (monthOfYear < 1 || monthOfYear > 12) {
            throw new IllegalArgumentException(
                    "Month of year should be in range of [1, 12]:" + monthOfYear);
        }
        checkTimeValue(startTime.mHour, startTime.mMinute);
        checkDurationValue(duration.mHour, duration.mMinute);
        // Recording sequence should use least 7 bits or no bits.
        if ((recordingSequence != 0)
                && ((recordingSequence & ~RECORDING_SEQUENCE_REPEAT_MASK) != 0)) {
            throw new IllegalArgumentException(
                    "Invalid reecording sequence value:" + recordingSequence);
        }

        return new TimerInfo(dayOfMonth, monthOfYear, startTime, duration, recordingSequence);
    }


Number 274:
API Relative Path:
src.android.hardware.hdmi.HdmiTimerRecordSources.java-timerInfoOf(int-int-Time-Duration-int)
Corresponding Source:
/**
     * Creates {@link TimerInfo} with the given information.
     *
     * @param dayOfMonth day of month
     * @param monthOfYear month of year
     * @param startTime start time in {@link Time}
     * @param duration duration in {@link Duration}
     * @param recordingSequence recording sequence. Use RECORDING_SEQUENCE_REPEAT_ONCE_ONLY for no
     *            repeat. Otherwise use combination of {@link #RECORDING_SEQUENCE_REPEAT_SUNDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_MONDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_TUESDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_WEDNESDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_THURSDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_FRIDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_SATUREDAY}.
     * @return {@link TimerInfo}.
     * @throws IllegalArgumentException if input value is invalid
     */
    public static TimerInfo timerInfoOf(int dayOfMonth, int monthOfYear, Time startTime,
            Duration duration, int recordingSequence) {
        if (dayOfMonth < 0 || dayOfMonth > 31) {
            throw new IllegalArgumentException(
                    "Day of month should be in range of [0, 31]:" + dayOfMonth);
        }
        if (monthOfYear < 1 || monthOfYear > 12) {
            throw new IllegalArgumentException(
                    "Month of year should be in range of [1, 12]:" + monthOfYear);
        }
        checkTimeValue(startTime.mHour, startTime.mMinute);
        checkDurationValue(duration.mHour, duration.mMinute);
        // Recording sequence should use least 7 bits or no bits.
        if ((recordingSequence != 0)
                && ((recordingSequence & ~RECORDING_SEQUENCE_REPEAT_MASK) != 0)) {
            throw new IllegalArgumentException(
                    "Invalid reecording sequence value:" + recordingSequence);
        }

        return new TimerInfo(dayOfMonth, monthOfYear, startTime, duration, recordingSequence);
    }


Number 275:
API Relative Path:
src.android.hardware.hdmi.HdmiTimerRecordSources.java-timerInfoOf(int-int-Time-Duration-int)
Corresponding Source:
/**
     * Creates {@link TimerInfo} with the given information.
     *
     * @param dayOfMonth day of month
     * @param monthOfYear month of year
     * @param startTime start time in {@link Time}
     * @param duration duration in {@link Duration}
     * @param recordingSequence recording sequence. Use RECORDING_SEQUENCE_REPEAT_ONCE_ONLY for no
     *            repeat. Otherwise use combination of {@link #RECORDING_SEQUENCE_REPEAT_SUNDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_MONDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_TUESDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_WEDNESDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_THURSDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_FRIDAY},
     *            {@link #RECORDING_SEQUENCE_REPEAT_SATUREDAY}.
     * @return {@link TimerInfo}.
     * @throws IllegalArgumentException if input value is invalid
     */
    public static TimerInfo timerInfoOf(int dayOfMonth, int monthOfYear, Time startTime,
            Duration duration, int recordingSequence) {
        if (dayOfMonth < 0 || dayOfMonth > 31) {
            throw new IllegalArgumentException(
                    "Day of month should be in range of [0, 31]:" + dayOfMonth);
        }
        if (monthOfYear < 1 || monthOfYear > 12) {
            throw new IllegalArgumentException(
                    "Month of year should be in range of [1, 12]:" + monthOfYear);
        }
        checkTimeValue(startTime.mHour, startTime.mMinute);
        checkDurationValue(duration.mHour, duration.mMinute);
        // Recording sequence should use least 7 bits or no bits.
        if ((recordingSequence != 0)
                && ((recordingSequence & ~RECORDING_SEQUENCE_REPEAT_MASK) != 0)) {
            throw new IllegalArgumentException(
                    "Invalid reecording sequence value:" + recordingSequence);
        }

        return new TimerInfo(dayOfMonth, monthOfYear, startTime, duration, recordingSequence);
    }


Number 276:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-clearTimerRecording(int-int-TimerRecordSource)
Corresponding Source:
/**
     * Clears timer recording with the given recorder address and recording source.
     * For more details, please refer {@link #startTimerRecording(int, int, TimerRecordSource)}.
     */
    public void clearTimerRecording(int recorderAddress, int sourceType, TimerRecordSource source) {
        if (source == null) {
            throw new IllegalArgumentException("source must not be null.");
        }

        checkTimerRecordingSourceType(sourceType);
        try {
            byte[] data = new byte[source.getDataSize()];
            source.toByteArray(data, 0);
            mService.clearTimerRecording(recorderAddress, sourceType, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to start record: ", e);
        }
    }


Number 277:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-deviceSelect(int-SelectCallback)
Corresponding Source:
/**
     * Selects a CEC logical device to be a new active source.
     *
     * @param logicalAddress logical address of the device to select
     * @param callback callback to get the result with
     * @throws {@link IllegalArgumentException} if the {@code callback} is null
     */
    public void deviceSelect(int logicalAddress, @NonNull SelectCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null.");
        }
        try {
            mService.deviceSelect(logicalAddress, getCallbackWrapper(callback));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to select device: ", e);
        }
    }


Number 278:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-portSelect(int-SelectCallback)
Corresponding Source:
/**
     * Selects a HDMI port to be a new route path.
     *
     * @param portId HDMI port to select
     * @param callback callback to get the result with
     * @throws {@link IllegalArgumentException} if the {@code callback} is null
     */
    public void portSelect(int portId, @NonNull SelectCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("Callback must not be null");
        }
        try {
            mService.portSelect(portId, getCallbackWrapper(callback));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to select port: ", e);
        }
    }


Number 279:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-sendMhlVendorCommand(int-int-int-byte[])
Corresponding Source:
/**
     * Sends MHL vendor command to the device connected to a port of the given portId.
     *
     * @param portId id of port to send MHL vendor command
     * @param offset offset in the in given data
     * @param length length of data. offset + length should be bound to length of data.
     * @param data container for vendor command data. It should be 16 bytes.
     * @throws IllegalArgumentException if the given parameters are invalid
     */
    public void sendMhlVendorCommand(int portId, int offset, int length, byte[] data) {
        if (data == null || data.length != VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid vendor command data.");
        }
        if (offset < 0 || offset >= VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid offset:" + offset);
        }
        if (length < 0 || offset + length > VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid length:" + length);
        }

        try {
            mService.sendMhlVendorCommand(portId, offset, length, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to send vendor command: ", e);
        }
    }


Number 280:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-sendMhlVendorCommand(int-int-int-byte[])
Corresponding Source:
/**
     * Sends MHL vendor command to the device connected to a port of the given portId.
     *
     * @param portId id of port to send MHL vendor command
     * @param offset offset in the in given data
     * @param length length of data. offset + length should be bound to length of data.
     * @param data container for vendor command data. It should be 16 bytes.
     * @throws IllegalArgumentException if the given parameters are invalid
     */
    public void sendMhlVendorCommand(int portId, int offset, int length, byte[] data) {
        if (data == null || data.length != VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid vendor command data.");
        }
        if (offset < 0 || offset >= VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid offset:" + offset);
        }
        if (length < 0 || offset + length > VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid length:" + length);
        }

        try {
            mService.sendMhlVendorCommand(portId, offset, length, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to send vendor command: ", e);
        }
    }


Number 281:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-sendMhlVendorCommand(int-int-int-byte[])
Corresponding Source:
/**
     * Sends MHL vendor command to the device connected to a port of the given portId.
     *
     * @param portId id of port to send MHL vendor command
     * @param offset offset in the in given data
     * @param length length of data. offset + length should be bound to length of data.
     * @param data container for vendor command data. It should be 16 bytes.
     * @throws IllegalArgumentException if the given parameters are invalid
     */
    public void sendMhlVendorCommand(int portId, int offset, int length, byte[] data) {
        if (data == null || data.length != VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid vendor command data.");
        }
        if (offset < 0 || offset >= VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid offset:" + offset);
        }
        if (length < 0 || offset + length > VENDOR_DATA_SIZE) {
            throw new IllegalArgumentException("Invalid length:" + length);
        }

        try {
            mService.sendMhlVendorCommand(portId, offset, length, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to send vendor command: ", e);
        }
    }


Number 282:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-setHdmiMhlVendorCommandListener(HdmiMhlVendorCommandListener)
Corresponding Source:
/**
     * Sets {@link HdmiMhlVendorCommandListener} to get incoming MHL vendor command.
     *
     * @param listener to receive incoming MHL vendor command
     */
    public void setHdmiMhlVendorCommandListener(HdmiMhlVendorCommandListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null.");
        }
        try {
            mService.addHdmiMhlVendorCommandListener(getListenerWrapper(listener));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set hdmi mhl vendor command listener: ", e);
        }
    }


Number 283:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-setInputChangeListener(InputChangeListener)
Corresponding Source:
/**
     * Sets the listener used to get informed of the input change event.
     *
     * @param listener listener object
     */
    public void setInputChangeListener(InputChangeListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null.");
        }
        try {
            mService.setInputChangeListener(getListenerWrapper(listener));
        } catch (RemoteException e) {
            Log.e("TAG", "Failed to set InputChangeListener:", e);
        }
    }


Number 284:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-setRecordListener(HdmiRecordListener)
Corresponding Source:
/**
     * Sets record listener.
     *
     * @param listener
     */
    public void setRecordListener(@NonNull HdmiRecordListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null.");
        }
        try {
            mService.setHdmiRecordListener(getListenerWrapper(listener));
        } catch (RemoteException e) {
            Log.e(TAG, "failed to set record listener.", e);
        }
    }


Number 285:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-startOneTouchRecord(int-RecordSource)
Corresponding Source:
/**
     * Starts one touch recording with the given recorder address and recorder source.
     * <p>
     * Usage
     * <pre>
     * HdmiTvClient tvClient = ....;
     * // for own source.
     * OwnSource ownSource = HdmiRecordSources.ofOwnSource();
     * tvClient.startOneTouchRecord(recorderAddress, ownSource);
     * </pre>
     */
    public void startOneTouchRecord(int recorderAddress, @NonNull RecordSource source) {
        if (source == null) {
            throw new IllegalArgumentException("source must not be null.");
        }

        try {
            byte[] data = new byte[source.getDataSize(true)];
            source.toByteArray(true, data, 0);
            mService.startOneTouchRecord(recorderAddress, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to start record: ", e);
        }
    }


Number 286:
API Relative Path:
src.android.hardware.hdmi.HdmiTvClient.java-startTimerRecording(int-int-TimerRecordSource)
Corresponding Source:
/**
     * Starts timer recording with the given recoder address and recorder source.
     * <p>
     * Usage
     * <pre>
     * HdmiTvClient tvClient = ....;
     * // create timer info
     * TimerInfo timerInfo = HdmiTimerRecourdSources.timerInfoOf(...);
     * // for digital source.
     * DigitalServiceSource recordSource = HdmiRecordSources.ofDigitalService(...);
     * // create timer recording source.
     * TimerRecordSource source = HdmiTimerRecourdSources.ofDigitalSource(timerInfo, recordSource);
     * tvClient.startTimerRecording(recorderAddress, source);
     * </pre>
     *
     * @param recorderAddress target recorder address
     * @param sourceType type of record source. It should be one of
     *          {@link HdmiControlManager#TIMER_RECORDING_TYPE_DIGITAL},
     *          {@link HdmiControlManager#TIMER_RECORDING_TYPE_ANALOGUE},
     *          {@link HdmiControlManager#TIMER_RECORDING_TYPE_EXTERNAL}.
     * @param source record source to be used
     */
    public void startTimerRecording(int recorderAddress, int sourceType, TimerRecordSource source) {
        if (source == null) {
            throw new IllegalArgumentException("source must not be null.");
        }

        checkTimerRecordingSourceType(sourceType);

        try {
            byte[] data = new byte[source.getDataSize()];
            source.toByteArray(data, 0);
            mService.startTimerRecording(recorderAddress, sourceType, data);
        } catch (RemoteException e) {
            Log.e(TAG, "failed to start record: ", e);
        }
    }


Number 287:
API Relative Path:
src.android.hardware.input.InputManager.java-addKeyboardLayoutForInputDevice(InputDeviceIdentifier-String)
Corresponding Source:
/**
     * Adds the keyboard layout descriptor for the specified input device.
     * <p>
     * This method may have the side-effect of causing the input device in
     * question to be reconfigured.
     * </p>
     *
     * @param identifier The identifier for the input device.
     * @param keyboardLayoutDescriptor The descriptor of the keyboard layout to
     *            add.
     * @hide
     */
    public void addKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            mIm.addKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 288:
API Relative Path:
src.android.hardware.input.InputManager.java-addKeyboardLayoutForInputDevice(InputDeviceIdentifier-String)
Corresponding Source:
/**
     * Adds the keyboard layout descriptor for the specified input device.
     * <p>
     * This method may have the side-effect of causing the input device in
     * question to be reconfigured.
     * </p>
     *
     * @param identifier The identifier for the input device.
     * @param keyboardLayoutDescriptor The descriptor of the keyboard layout to
     *            add.
     * @hide
     */
    public void addKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            mIm.addKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 289:
API Relative Path:
src.android.hardware.input.InputManager.java-getEnabledKeyboardLayoutsForInputDevice(InputDeviceIdentifier)
Corresponding Source:
/**
     * Gets all keyboard layout descriptors that are enabled for the specified
     * input device.
     *
     * @param identifier The identifier for the input device.
     * @return The keyboard layout descriptors.
     * @hide
     */
    public String[] getEnabledKeyboardLayoutsForInputDevice(InputDeviceIdentifier identifier) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }

        try {
            return mIm.getEnabledKeyboardLayoutsForInputDevice(identifier);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 290:
API Relative Path:
src.android.hardware.input.InputManager.java-getInputDeviceByDescriptor(String)
Corresponding Source:
/**
     * Gets information about the input device with the specified descriptor.
     * @param descriptor The input device descriptor.
     * @return The input device or null if not found.
     * @hide
     */
    public InputDevice getInputDeviceByDescriptor(String descriptor) {
        if (descriptor == null) {
            throw new IllegalArgumentException("descriptor must not be null.");
        }

        synchronized (mInputDevicesLock) {
            populateInputDevicesLocked();

            int numDevices = mInputDevices.size();
            for (int i = 0; i < numDevices; i++) {
                InputDevice inputDevice = mInputDevices.valueAt(i);
                if (inputDevice == null) {
                    int id = mInputDevices.keyAt(i);
                    try {
                        inputDevice = mIm.getInputDevice(id);
                    } catch (RemoteException ex) {
                        throw ex.rethrowFromSystemServer();
                    }
                    if (inputDevice == null) {
                        continue;
                    }
                    mInputDevices.setValueAt(i, inputDevice);
                }
                if (descriptor.equals(inputDevice.getDescriptor())) {
                    return inputDevice;
                }
            }
            return null;
        }
    }


Number 291:
API Relative Path:
src.android.hardware.input.InputManager.java-getKeyboardLayout(String)
Corresponding Source:
/**
     * Gets the keyboard layout with the specified descriptor.
     *
     * @param keyboardLayoutDescriptor The keyboard layout descriptor, as returned by
     * {@link KeyboardLayout#getDescriptor()}.
     * @return The keyboard layout, or null if it could not be loaded.
     *
     * @hide
     */
    public KeyboardLayout getKeyboardLayout(String keyboardLayoutDescriptor) {
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            return mIm.getKeyboardLayout(keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 292:
API Relative Path:
src.android.hardware.input.InputManager.java-injectInputEvent(InputEvent-int)
Corresponding Source:
/**
     * Injects an input event into the event system on behalf of an application.
     * The synchronization mode determines whether the method blocks while waiting for
     * input injection to proceed.
     * <p>
     * Requires {@link android.Manifest.permission.INJECT_EVENTS} to inject into
     * windows that are owned by other applications.
     * </p><p>
     * Make sure you correctly set the event time and input source of the event
     * before calling this method.
     * </p>
     *
     * @param event The event to inject.
     * @param mode The synchronization mode.  One of:
     * {@link #INJECT_INPUT_EVENT_MODE_ASYNC},
     * {@link #INJECT_INPUT_EVENT_MODE_WAIT_FOR_RESULT}, or
     * {@link #INJECT_INPUT_EVENT_MODE_WAIT_FOR_FINISH}.
     * @return True if input event injection succeeded.
     *
     * @hide
     */
    public boolean injectInputEvent(InputEvent event, int mode) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        }
        if (mode != INJECT_INPUT_EVENT_MODE_ASYNC
                && mode != INJECT_INPUT_EVENT_MODE_WAIT_FOR_FINISH
                && mode != INJECT_INPUT_EVENT_MODE_WAIT_FOR_RESULT) {
            throw new IllegalArgumentException("mode is invalid");
        }

        try {
            return mIm.injectInputEvent(event, mode);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 293:
API Relative Path:
src.android.hardware.input.InputManager.java-injectInputEvent(InputEvent-int)
Corresponding Source:
/**
     * Injects an input event into the event system on behalf of an application.
     * The synchronization mode determines whether the method blocks while waiting for
     * input injection to proceed.
     * <p>
     * Requires {@link android.Manifest.permission.INJECT_EVENTS} to inject into
     * windows that are owned by other applications.
     * </p><p>
     * Make sure you correctly set the event time and input source of the event
     * before calling this method.
     * </p>
     *
     * @param event The event to inject.
     * @param mode The synchronization mode.  One of:
     * {@link #INJECT_INPUT_EVENT_MODE_ASYNC},
     * {@link #INJECT_INPUT_EVENT_MODE_WAIT_FOR_RESULT}, or
     * {@link #INJECT_INPUT_EVENT_MODE_WAIT_FOR_FINISH}.
     * @return True if input event injection succeeded.
     *
     * @hide
     */
    public boolean injectInputEvent(InputEvent event, int mode) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        }
        if (mode != INJECT_INPUT_EVENT_MODE_ASYNC
                && mode != INJECT_INPUT_EVENT_MODE_WAIT_FOR_FINISH
                && mode != INJECT_INPUT_EVENT_MODE_WAIT_FOR_RESULT) {
            throw new IllegalArgumentException("mode is invalid");
        }

        try {
            return mIm.injectInputEvent(event, mode);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 294:
API Relative Path:
src.android.hardware.input.InputManager.java-registerInputDeviceListener(InputDeviceListener-Handler)
Corresponding Source:
/**
     * Registers an input device listener to receive notifications about when
     * input devices are added, removed or changed.
     *
     * @param listener The listener to register.
     * @param handler The handler on which the listener should be invoked, or null
     * if the listener should be invoked on the calling thread's looper.
     *
     * @see #unregisterInputDeviceListener
     */
    public void registerInputDeviceListener(InputDeviceListener listener, Handler handler) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }

        synchronized (mInputDevicesLock) {
            populateInputDevicesLocked();
            int index = findInputDeviceListenerLocked(listener);
            if (index < 0) {
                mInputDeviceListeners.add(new InputDeviceListenerDelegate(listener, handler));
            }
        }
    }


Number 295:
API Relative Path:
src.android.hardware.input.InputManager.java-registerOnTabletModeChangedListener(OnTabletModeChangedListener-Handler)
Corresponding Source:
/**
     * Register a tablet mode changed listener.
     *
     * @param listener The listener to register.
     * @param handler The handler on which the listener should be invoked, or null
     * if the listener should be invoked on the calling thread's looper.
     * @hide
     */
    public void registerOnTabletModeChangedListener(
            OnTabletModeChangedListener listener, Handler handler) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        synchronized (mTabletModeLock) {
            if (mOnTabletModeChangedListeners == null) {
                initializeTabletModeListenerLocked();
            }
            int idx = findOnTabletModeChangedListenerLocked(listener);
            if (idx < 0) {
                OnTabletModeChangedListenerDelegate d =
                    new OnTabletModeChangedListenerDelegate(listener, handler);
                mOnTabletModeChangedListeners.add(d);
            }
        }
    }


Number 296:
API Relative Path:
src.android.hardware.input.InputManager.java-removeKeyboardLayoutForInputDevice(InputDeviceIdentifier-String)
Corresponding Source:
/**
     * Removes the keyboard layout descriptor for the specified input device.
     * <p>
     * This method may have the side-effect of causing the input device in
     * question to be reconfigured.
     * </p>
     *
     * @param identifier The identifier for the input device.
     * @param keyboardLayoutDescriptor The descriptor of the keyboard layout to
     *            remove.
     * @hide
     */
    public void removeKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            mIm.removeKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 297:
API Relative Path:
src.android.hardware.input.InputManager.java-removeKeyboardLayoutForInputDevice(InputDeviceIdentifier-String)
Corresponding Source:
/**
     * Removes the keyboard layout descriptor for the specified input device.
     * <p>
     * This method may have the side-effect of causing the input device in
     * question to be reconfigured.
     * </p>
     *
     * @param identifier The identifier for the input device.
     * @param keyboardLayoutDescriptor The descriptor of the keyboard layout to
     *            remove.
     * @hide
     */
    public void removeKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            mIm.removeKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 298:
API Relative Path:
src.android.hardware.input.InputManager.java-setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier-String)
Corresponding Source:
/**
     * Sets the current keyboard layout descriptor for the specified input
     * device.
     * <p>
     * This method may have the side-effect of causing the input device in
     * question to be reconfigured.
     * </p>
     *
     * @param identifier The identifier for the input device.
     * @param keyboardLayoutDescriptor The keyboard layout descriptor to use,
     *            must not be null.
     * @hide
     */
    public void setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("identifier must not be null");
        }
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            mIm.setCurrentKeyboardLayoutForInputDevice(identifier,
                    keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 299:
API Relative Path:
src.android.hardware.input.InputManager.java-setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier-String)
Corresponding Source:
/**
     * Sets the current keyboard layout descriptor for the specified input
     * device.
     * <p>
     * This method may have the side-effect of causing the input device in
     * question to be reconfigured.
     * </p>
     *
     * @param identifier The identifier for the input device.
     * @param keyboardLayoutDescriptor The keyboard layout descriptor to use,
     *            must not be null.
     * @hide
     */
    public void setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("identifier must not be null");
        }
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }

        try {
            mIm.setCurrentKeyboardLayoutForInputDevice(identifier,
                    keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 300:
API Relative Path:
src.android.hardware.input.InputManager.java-setPointerSpeed(Context-int)
Corresponding Source:
/**
     * Sets the mouse pointer speed.
     * <p>
     * Requires {@link android.Manifest.permissions.WRITE_SETTINGS}.
     * </p>
     *
     * @param context The application context.
     * @param speed The pointer speed as a value between {@link #MIN_POINTER_SPEED} and
     * {@link #MAX_POINTER_SPEED}, or the default value {@link #DEFAULT_POINTER_SPEED}.
     *
     * @hide
     */
    public void setPointerSpeed(Context context, int speed) {
        if (speed < MIN_POINTER_SPEED || speed > MAX_POINTER_SPEED) {
            throw new IllegalArgumentException("speed out of range");
        }

        Settings.System.putInt(context.getContentResolver(),
                Settings.System.POINTER_SPEED, speed);
    }


Number 301:
API Relative Path:
src.android.hardware.input.InputManager.java-tryPointerSpeed(int)
Corresponding Source:
/**
     * Changes the mouse pointer speed temporarily, but does not save the setting.
     * <p>
     * Requires {@link android.Manifest.permission.SET_POINTER_SPEED}.
     * </p>
     *
     * @param speed The pointer speed as a value between {@link #MIN_POINTER_SPEED} and
     * {@link #MAX_POINTER_SPEED}, or the default value {@link #DEFAULT_POINTER_SPEED}.
     *
     * @hide
     */
    public void tryPointerSpeed(int speed) {
        if (speed < MIN_POINTER_SPEED || speed > MAX_POINTER_SPEED) {
            throw new IllegalArgumentException("speed out of range");
        }

        try {
            mIm.tryPointerSpeed(speed);
        } catch (RemoteException ex) {
            throw ex.rethrowFromSystemServer();
        }
    }


Number 302:
API Relative Path:
src.android.hardware.input.InputManager.java-unregisterInputDeviceListener(InputDeviceListener)
Corresponding Source:
/**
     * Unregisters an input device listener.
     *
     * @param listener The listener to unregister.
     *
     * @see #registerInputDeviceListener
     */
    public void unregisterInputDeviceListener(InputDeviceListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }

        synchronized (mInputDevicesLock) {
            int index = findInputDeviceListenerLocked(listener);
            if (index >= 0) {
                InputDeviceListenerDelegate d = mInputDeviceListeners.get(index);
                d.removeCallbacksAndMessages(null);
                mInputDeviceListeners.remove(index);
            }
        }
    }


Number 303:
API Relative Path:
src.android.hardware.input.InputManager.java-unregisterOnTabletModeChangedListener(OnTabletModeChangedListener)
Corresponding Source:
/**
     * Unregister a tablet mode changed listener.
     *
     * @param listener The listener to unregister.
     * @hide
     */
    public void unregisterOnTabletModeChangedListener(OnTabletModeChangedListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        synchronized (mTabletModeLock) {
            int idx = findOnTabletModeChangedListenerLocked(listener);
            if (idx >= 0) {
                OnTabletModeChangedListenerDelegate d = mOnTabletModeChangedListeners.remove(idx);
                d.removeCallbacksAndMessages(null);
            }
        }
    }


Number 304:
API Relative Path:
src.android.hardware.SensorManager.java-injectSensorData(Sensor-float[]-int-long)
Corresponding Source:
/**
     * For testing purposes only. Not for third party applications.
     *
     * This method is used to inject raw sensor data into the HAL.  Call {@link
     * initDataInjection(boolean)} before this method to set the HAL in data injection mode. This
     * method should be called only if a previous call to initDataInjection has been successful and
     * the HAL and SensorService are already opreating in data injection mode.
     *
     * @param sensor The sensor to inject.
     * @param values Sensor values to inject. The length of this
     *               array must be exactly equal to the number of
     *               values reported by the sensor type.
     * @param accuracy Accuracy of the sensor.
     * @param timestamp Sensor timestamp associated with the event.
     *
     * @return boolean True if the data injection succeeds, false
     *         otherwise.
     * @throws IllegalArgumentException when the sensor is null,
     *         data injection is not supported by the sensor, values
     *         are null, incorrect number of values for the sensor,
     *         sensor accuracy is incorrect or timestamps are
     *         invalid.
     * @hide
     */
    @SystemApi
    public boolean injectSensorData(Sensor sensor, float[] values, int accuracy,
                long timestamp) {
        if (sensor == null) {
            throw new IllegalArgumentException("sensor cannot be null");
        }
        if (!sensor.isDataInjectionSupported()) {
            throw new IllegalArgumentException("sensor does not support data injection");
        }
        if (values == null) {
            throw new IllegalArgumentException("sensor data cannot be null");
        }
        int expectedNumValues = Sensor.getMaxLengthValuesArray(sensor, Build.VERSION_CODES.M);
        if (values.length != expectedNumValues) {
            throw new  IllegalArgumentException ("Wrong number of values for sensor " +
                    sensor.getName() + " actual=" + values.length + " expected=" +
                                                  expectedNumValues);
        }
        if (accuracy < SENSOR_STATUS_NO_CONTACT || accuracy > SENSOR_STATUS_ACCURACY_HIGH) {
            throw new IllegalArgumentException("Invalid sensor accuracy");
        }
        if (timestamp <= 0) {
            throw new IllegalArgumentException("Negative or zero sensor timestamp");
        }
        return injectSensorDataImpl(sensor, values, accuracy, timestamp);
    }


Number 305:
API Relative Path:
src.android.hardware.SensorManager.java-injectSensorData(Sensor-float[]-int-long)
Corresponding Source:
/**
     * For testing purposes only. Not for third party applications.
     *
     * This method is used to inject raw sensor data into the HAL.  Call {@link
     * initDataInjection(boolean)} before this method to set the HAL in data injection mode. This
     * method should be called only if a previous call to initDataInjection has been successful and
     * the HAL and SensorService are already opreating in data injection mode.
     *
     * @param sensor The sensor to inject.
     * @param values Sensor values to inject. The length of this
     *               array must be exactly equal to the number of
     *               values reported by the sensor type.
     * @param accuracy Accuracy of the sensor.
     * @param timestamp Sensor timestamp associated with the event.
     *
     * @return boolean True if the data injection succeeds, false
     *         otherwise.
     * @throws IllegalArgumentException when the sensor is null,
     *         data injection is not supported by the sensor, values
     *         are null, incorrect number of values for the sensor,
     *         sensor accuracy is incorrect or timestamps are
     *         invalid.
     * @hide
     */
    @SystemApi
    public boolean injectSensorData(Sensor sensor, float[] values, int accuracy,
                long timestamp) {
        if (sensor == null) {
            throw new IllegalArgumentException("sensor cannot be null");
        }
        if (!sensor.isDataInjectionSupported()) {
            throw new IllegalArgumentException("sensor does not support data injection");
        }
        if (values == null) {
            throw new IllegalArgumentException("sensor data cannot be null");
        }
        int expectedNumValues = Sensor.getMaxLengthValuesArray(sensor, Build.VERSION_CODES.M);
        if (values.length != expectedNumValues) {
            throw new  IllegalArgumentException ("Wrong number of values for sensor " +
                    sensor.getName() + " actual=" + values.length + " expected=" +
                                                  expectedNumValues);
        }
        if (accuracy < SENSOR_STATUS_NO_CONTACT || accuracy > SENSOR_STATUS_ACCURACY_HIGH) {
            throw new IllegalArgumentException("Invalid sensor accuracy");
        }
        if (timestamp <= 0) {
            throw new IllegalArgumentException("Negative or zero sensor timestamp");
        }
        return injectSensorDataImpl(sensor, values, accuracy, timestamp);
    }


Number 306:
API Relative Path:
src.android.hardware.SensorManager.java-injectSensorData(Sensor-float[]-int-long)
Corresponding Source:
/**
     * For testing purposes only. Not for third party applications.
     *
     * This method is used to inject raw sensor data into the HAL.  Call {@link
     * initDataInjection(boolean)} before this method to set the HAL in data injection mode. This
     * method should be called only if a previous call to initDataInjection has been successful and
     * the HAL and SensorService are already opreating in data injection mode.
     *
     * @param sensor The sensor to inject.
     * @param values Sensor values to inject. The length of this
     *               array must be exactly equal to the number of
     *               values reported by the sensor type.
     * @param accuracy Accuracy of the sensor.
     * @param timestamp Sensor timestamp associated with the event.
     *
     * @return boolean True if the data injection succeeds, false
     *         otherwise.
     * @throws IllegalArgumentException when the sensor is null,
     *         data injection is not supported by the sensor, values
     *         are null, incorrect number of values for the sensor,
     *         sensor accuracy is incorrect or timestamps are
     *         invalid.
     * @hide
     */
    @SystemApi
    public boolean injectSensorData(Sensor sensor, float[] values, int accuracy,
                long timestamp) {
        if (sensor == null) {
            throw new IllegalArgumentException("sensor cannot be null");
        }
        if (!sensor.isDataInjectionSupported()) {
            throw new IllegalArgumentException("sensor does not support data injection");
        }
        if (values == null) {
            throw new IllegalArgumentException("sensor data cannot be null");
        }
        int expectedNumValues = Sensor.getMaxLengthValuesArray(sensor, Build.VERSION_CODES.M);
        if (values.length != expectedNumValues) {
            throw new  IllegalArgumentException ("Wrong number of values for sensor " +
                    sensor.getName() + " actual=" + values.length + " expected=" +
                                                  expectedNumValues);
        }
        if (accuracy < SENSOR_STATUS_NO_CONTACT || accuracy > SENSOR_STATUS_ACCURACY_HIGH) {
            throw new IllegalArgumentException("Invalid sensor accuracy");
        }
        if (timestamp <= 0) {
            throw new IllegalArgumentException("Negative or zero sensor timestamp");
        }
        return injectSensorDataImpl(sensor, values, accuracy, timestamp);
    }


Number 307:
API Relative Path:
src.android.hardware.SensorManager.java-injectSensorData(Sensor-float[]-int-long)
Corresponding Source:
/**
     * For testing purposes only. Not for third party applications.
     *
     * This method is used to inject raw sensor data into the HAL.  Call {@link
     * initDataInjection(boolean)} before this method to set the HAL in data injection mode. This
     * method should be called only if a previous call to initDataInjection has been successful and
     * the HAL and SensorService are already opreating in data injection mode.
     *
     * @param sensor The sensor to inject.
     * @param values Sensor values to inject. The length of this
     *               array must be exactly equal to the number of
     *               values reported by the sensor type.
     * @param accuracy Accuracy of the sensor.
     * @param timestamp Sensor timestamp associated with the event.
     *
     * @return boolean True if the data injection succeeds, false
     *         otherwise.
     * @throws IllegalArgumentException when the sensor is null,
     *         data injection is not supported by the sensor, values
     *         are null, incorrect number of values for the sensor,
     *         sensor accuracy is incorrect or timestamps are
     *         invalid.
     * @hide
     */
    @SystemApi
    public boolean injectSensorData(Sensor sensor, float[] values, int accuracy,
                long timestamp) {
        if (sensor == null) {
            throw new IllegalArgumentException("sensor cannot be null");
        }
        if (!sensor.isDataInjectionSupported()) {
            throw new IllegalArgumentException("sensor does not support data injection");
        }
        if (values == null) {
            throw new IllegalArgumentException("sensor data cannot be null");
        }
        int expectedNumValues = Sensor.getMaxLengthValuesArray(sensor, Build.VERSION_CODES.M);
        if (values.length != expectedNumValues) {
            throw new  IllegalArgumentException ("Wrong number of values for sensor " +
                    sensor.getName() + " actual=" + values.length + " expected=" +
                                                  expectedNumValues);
        }
        if (accuracy < SENSOR_STATUS_NO_CONTACT || accuracy > SENSOR_STATUS_ACCURACY_HIGH) {
            throw new IllegalArgumentException("Invalid sensor accuracy");
        }
        if (timestamp <= 0) {
            throw new IllegalArgumentException("Negative or zero sensor timestamp");
        }
        return injectSensorDataImpl(sensor, values, accuracy, timestamp);
    }


Number 308:
API Relative Path:
src.android.hardware.SensorManager.java-unregisterListener(SensorEventListener)
Corresponding Source:
/**
     * Unregisters a listener for all sensors.
     *
     * @param listener
     *        a SensorListener object
     *
     * @see #unregisterListener(SensorEventListener, Sensor)
     * @see #registerListener(SensorEventListener, Sensor, int)
     *
     */
    public void unregisterListener(SensorEventListener listener) {
        if (listener == null) {
            return;
        }

        unregisterListenerImpl(listener, null);
    }


Number 309:
API Relative Path:
src.android.hardware.SensorManager.java-unregisterListener(SensorEventListener-Sensor)
Corresponding Source:
/**
     * Unregisters a listener for the sensors with which it is registered.
     *
     * <p class="note"></p>
     * Note: Don't use this method with a one shot trigger sensor such as
     * {@link Sensor#TYPE_SIGNIFICANT_MOTION}.
     * Use {@link #cancelTriggerSensor(TriggerEventListener, Sensor)} instead.
     * </p>
     *
     * @param listener
     *        a SensorEventListener object
     *
     * @param sensor
     *        the sensor to unregister from
     *
     * @see #unregisterListener(SensorEventListener)
     * @see #registerListener(SensorEventListener, Sensor, int)
     */
    public void unregisterListener(SensorEventListener listener, Sensor sensor) {
        if (listener == null || sensor == null) {
            return;
        }

        unregisterListenerImpl(listener, sensor);
    }


Number 310:
API Relative Path:
src.android.hardware.soundtrigger.SoundTrigger.java-attachModule(int-StatusListener-Handler)
Corresponding Source:
/**
     * Get an interface on a hardware module to control sound models and recognition on
     * this module.
     * @param moduleId Sound module system identifier {@link ModuleProperties#id}. mandatory.
     * @param listener {@link StatusListener} interface. Mandatory.
     * @param handler the Handler that will receive the callabcks. Can be null if default handler
     *                is OK.
     * @return a valid sound module in case of success or null in case of error.
     */
    public static SoundTriggerModule attachModule(int moduleId,
                                                  StatusListener listener,
                                                  Handler handler) {
        if (listener == null) {
            return null;
        }
        SoundTriggerModule module = new SoundTriggerModule(moduleId, listener, handler);
        return module;
    }


Number 311:
API Relative Path:
src.android.hardware.SystemSensorManager.java-registerDynamicSensorCallbackImpl(DynamicSensorCallback-Handler)
Corresponding Source:
/** @hide */
    protected void registerDynamicSensorCallbackImpl(
            DynamicSensorCallback callback, Handler handler) {
        if (DEBUG_DYNAMIC_SENSOR) {
            Log.i(TAG, "DYNS Register dynamic sensor callback");
        }

        if (callback == null) {
            throw new IllegalArgumentException("callback cannot be null");
        }
        if (mDynamicSensorCallbacks.containsKey(callback)) {
            // has been already registered, ignore
            return;
        }

        setupDynamicSensorBroadcastReceiver();
        mDynamicSensorCallbacks.put(callback, handler);
    }


Number 312:
API Relative Path:
src.android.hardware.SystemSensorManager.java-requestTriggerSensorImpl(TriggerEventListener-Sensor)
Corresponding Source:
/** @hide */
    @Override
    protected boolean requestTriggerSensorImpl(TriggerEventListener listener, Sensor sensor) {
        if (sensor == null) throw new IllegalArgumentException("sensor cannot be null");

        if (listener == null) throw new IllegalArgumentException("listener cannot be null");

        if (sensor.getReportingMode() != Sensor.REPORTING_MODE_ONE_SHOT) return false;

        synchronized (mTriggerListeners) {
            TriggerEventQueue queue = mTriggerListeners.get(listener);
            if (queue == null) {
                final String fullClassName = listener.getClass().getEnclosingClass() != null ?
                    listener.getClass().getEnclosingClass().getName() :
                    listener.getClass().getName();
                queue = new TriggerEventQueue(listener, mMainLooper, this, fullClassName);
                if (!queue.addSensor(sensor, 0, 0)) {
                    queue.dispose();
                    return false;
                }
                mTriggerListeners.put(listener, queue);
                return true;
            } else {
                return queue.addSensor(sensor, 0, 0);
            }
        }
    }


Number 313:
API Relative Path:
src.android.hardware.SystemSensorManager.java-requestTriggerSensorImpl(TriggerEventListener-Sensor)
Corresponding Source:
/** @hide */
    @Override
    protected boolean requestTriggerSensorImpl(TriggerEventListener listener, Sensor sensor) {
        if (sensor == null) throw new IllegalArgumentException("sensor cannot be null");

        if (listener == null) throw new IllegalArgumentException("listener cannot be null");

        if (sensor.getReportingMode() != Sensor.REPORTING_MODE_ONE_SHOT) return false;

        synchronized (mTriggerListeners) {
            TriggerEventQueue queue = mTriggerListeners.get(listener);
            if (queue == null) {
                final String fullClassName = listener.getClass().getEnclosingClass() != null ?
                    listener.getClass().getEnclosingClass().getName() :
                    listener.getClass().getName();
                queue = new TriggerEventQueue(listener, mMainLooper, this, fullClassName);
                if (!queue.addSensor(sensor, 0, 0)) {
                    queue.dispose();
                    return false;
                }
                mTriggerListeners.put(listener, queue);
                return true;
            } else {
                return queue.addSensor(sensor, 0, 0);
            }
        }
    }


Number 314:
API Relative Path:
src.android.hardware.SystemSensorManager.java-unregisterListenerImpl(SensorEventListener-Sensor)
Corresponding Source:
/** @hide */
    @Override
    protected void unregisterListenerImpl(SensorEventListener listener, Sensor sensor) {
        // Trigger Sensors should use the cancelTriggerSensor call.
        if (sensor != null && sensor.getReportingMode() == Sensor.REPORTING_MODE_ONE_SHOT) {
            return;
        }

        synchronized (mSensorListeners) {
            SensorEventQueue queue = mSensorListeners.get(listener);
            if (queue != null) {
                boolean result;
                if (sensor == null) {
                    result = queue.removeAllSensors();
                } else {
                    result = queue.removeSensor(sensor, true);
                }
                if (result && !queue.hasSensors()) {
                    mSensorListeners.remove(listener);
                    queue.dispose();
                }
            }
        }
    }


Number 315:
API Relative Path:
src.android.location.Country.java-Country(String-int)
Corresponding Source:
/**
     * @param countryIso the ISO 3166-1 two letters country code.
     * @param source where the countryIso came from, could be one of below
     *        values
     *        <p>
     *        <ul>
     *        <li>{@link #COUNTRY_SOURCE_NETWORK}</li>
     *        <li>{@link #COUNTRY_SOURCE_LOCATION}</li>
     *        <li>{@link #COUNTRY_SOURCE_SIM}</li>
     *        <li>{@link #COUNTRY_SOURCE_LOCALE}</li>
     *        </ul>
     */
    public Country(final String countryIso, final int source) {
        if (countryIso == null || source < COUNTRY_SOURCE_NETWORK
                || source > COUNTRY_SOURCE_LOCALE) {
            throw new IllegalArgumentException();
        }
        mCountryIso = countryIso.toUpperCase(Locale.US);
        mSource = source;
        mTimestamp = SystemClock.elapsedRealtime();
    }


Number 316:
API Relative Path:
src.android.location.Criteria.java-setAccuracy(int)
Corresponding Source:
/**
     * Indicates the desired accuracy for latitude and longitude. Accuracy
     * may be {@link #ACCURACY_FINE} if desired location
     * is fine, else it can be {@link #ACCURACY_COARSE}.
     * More accurate location may consume more power and may take longer.
     *
     * @throws IllegalArgumentException if accuracy is not one of the supported constants
     */
    public void setAccuracy(int accuracy) {
        if (accuracy < NO_REQUIREMENT || accuracy > ACCURACY_COARSE) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        if (accuracy == ACCURACY_FINE) {
            mHorizontalAccuracy = ACCURACY_HIGH;
        } else {
            mHorizontalAccuracy = ACCURACY_LOW;
        }
    }


Number 317:
API Relative Path:
src.android.location.Criteria.java-setBearingAccuracy(int)
Corresponding Source:
/**
     * Indicates the desired bearing accuracy.
     * Accuracy may be {@link #ACCURACY_LOW}, {@link #ACCURACY_HIGH},
     * or {@link #NO_REQUIREMENT}.
     * More accurate location may consume more power and may take longer.
     *
     * @throws IllegalArgumentException if accuracy is not one of the supported constants
     */
    public void setBearingAccuracy(int accuracy) {
        if (accuracy < NO_REQUIREMENT || accuracy > ACCURACY_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        mBearingAccuracy = accuracy;
    }


Number 318:
API Relative Path:
src.android.location.Criteria.java-setHorizontalAccuracy(int)
Corresponding Source:
/**
     * Indicates the desired horizontal accuracy (latitude and longitude).
     * Accuracy may be {@link #ACCURACY_LOW}, {@link #ACCURACY_MEDIUM},
     * {@link #ACCURACY_HIGH} or {@link #NO_REQUIREMENT}.
     * More accurate location may consume more power and may take longer.
     *
     * @throws IllegalArgumentException if accuracy is not one of the supported constants
     */
    public void setHorizontalAccuracy(int accuracy) {
        if (accuracy < NO_REQUIREMENT || accuracy > ACCURACY_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        mHorizontalAccuracy = accuracy;
    }


Number 319:
API Relative Path:
src.android.location.Criteria.java-setPowerRequirement(int)
Corresponding Source:
/**
     * Indicates the desired maximum power level.  The level parameter
     * must be one of NO_REQUIREMENT, POWER_LOW, POWER_MEDIUM, or
     * POWER_HIGH.
     */
    public void setPowerRequirement(int level) {
        if (level < NO_REQUIREMENT || level > POWER_HIGH) {
            throw new IllegalArgumentException("level=" + level);
        }
        mPowerRequirement = level;
    }


Number 320:
API Relative Path:
src.android.location.Criteria.java-setSpeedAccuracy(int)
Corresponding Source:
/**
     * Indicates the desired speed accuracy.
     * Accuracy may be {@link #ACCURACY_LOW}, {@link #ACCURACY_HIGH},
     * or {@link #NO_REQUIREMENT}.
     * More accurate location may consume more power and may take longer.
     *
     * @throws IllegalArgumentException if accuracy is not one of the supported constants
     */
    public void setSpeedAccuracy(int accuracy) {
        if (accuracy < NO_REQUIREMENT || accuracy > ACCURACY_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        mSpeedAccuracy = accuracy;
    }


Number 321:
API Relative Path:
src.android.location.Criteria.java-setVerticalAccuracy(int)
Corresponding Source:
/**
     * Indicates the desired vertical accuracy (altitude).
     * Accuracy may be {@link #ACCURACY_LOW}, {@link #ACCURACY_MEDIUM},
     * {@link #ACCURACY_HIGH} or {@link #NO_REQUIREMENT}.
     * More accurate location may consume more power and may take longer.
     *
     * @throws IllegalArgumentException if accuracy is not one of the supported constants
     */
    public void setVerticalAccuracy(int accuracy) {
        if (accuracy < NO_REQUIREMENT || accuracy > ACCURACY_HIGH) {
            throw new IllegalArgumentException("accuracy=" + accuracy);
        }
        mVerticalAccuracy = accuracy;
    }


Number 322:
API Relative Path:
src.android.location.Geocoder.java-getFromLocation(double-double-int)
Corresponding Source:
/**
     * Returns an array of Addresses that are known to describe the
     * area immediately surrounding the given latitude and longitude.
     * The returned addresses will be localized for the locale
     * provided to this class's constructor.
     *
     * <p> The returned values may be obtained by means of a network lookup.
     * The results are a best guess and are not guaranteed to be meaningful or
     * correct. It may be useful to call this method from a thread separate from your
     * primary UI thread.
     *
     * @param latitude the latitude a point for the search
     * @param longitude the longitude a point for the search
     * @param maxResults max number of addresses to return. Smaller numbers (1 to 5) are recommended
     *
     * @return a list of Address objects. Returns null or empty list if no matches were
     * found or there is no backend service available.
     *
     * @throws IllegalArgumentException if latitude is
     * less than -90 or greater than 90
     * @throws IllegalArgumentException if longitude is
     * less than -180 or greater than 180
     * @throws IOException if the network is unavailable or any other
     * I/O problem occurs
     */
    public List<Address> getFromLocation(double latitude, double longitude, int maxResults)
        throws IOException {
        if (latitude < -90.0 || latitude > 90.0) {
            throw new IllegalArgumentException("latitude == " + latitude);
        }
        if (longitude < -180.0 || longitude > 180.0) {
            throw new IllegalArgumentException("longitude == " + longitude);
        }
        try {
            List<Address> results = new ArrayList<Address>();
            String ex =  mService.getFromLocation(latitude, longitude, maxResults,
                mParams, results);
            if (ex != null) {
                throw new IOException(ex);
            } else {
                return results;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getFromLocation: got RemoteException", e);
            return null;
        }
    }


Number 323:
API Relative Path:
src.android.location.Geocoder.java-getFromLocation(double-double-int)
Corresponding Source:
/**
     * Returns an array of Addresses that are known to describe the
     * area immediately surrounding the given latitude and longitude.
     * The returned addresses will be localized for the locale
     * provided to this class's constructor.
     *
     * <p> The returned values may be obtained by means of a network lookup.
     * The results are a best guess and are not guaranteed to be meaningful or
     * correct. It may be useful to call this method from a thread separate from your
     * primary UI thread.
     *
     * @param latitude the latitude a point for the search
     * @param longitude the longitude a point for the search
     * @param maxResults max number of addresses to return. Smaller numbers (1 to 5) are recommended
     *
     * @return a list of Address objects. Returns null or empty list if no matches were
     * found or there is no backend service available.
     *
     * @throws IllegalArgumentException if latitude is
     * less than -90 or greater than 90
     * @throws IllegalArgumentException if longitude is
     * less than -180 or greater than 180
     * @throws IOException if the network is unavailable or any other
     * I/O problem occurs
     */
    public List<Address> getFromLocation(double latitude, double longitude, int maxResults)
        throws IOException {
        if (latitude < -90.0 || latitude > 90.0) {
            throw new IllegalArgumentException("latitude == " + latitude);
        }
        if (longitude < -180.0 || longitude > 180.0) {
            throw new IllegalArgumentException("longitude == " + longitude);
        }
        try {
            List<Address> results = new ArrayList<Address>();
            String ex =  mService.getFromLocation(latitude, longitude, maxResults,
                mParams, results);
            if (ex != null) {
                throw new IOException(ex);
            } else {
                return results;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getFromLocation: got RemoteException", e);
            return null;
        }
    }


Number 324:
API Relative Path:
src.android.location.Geocoder.java-getFromLocationName(String-int-double-double-double-double)
Corresponding Source:
/**
     * Returns an array of Addresses that are known to describe the
     * named location, which may be a place name such as "Dalvik,
     * Iceland", an address such as "1600 Amphitheatre Parkway,
     * Mountain View, CA", an airport code such as "SFO", etc..  The
     * returned addresses will be localized for the locale provided to
     * this class's constructor.
     *
     * <p> You may specify a bounding box for the search results by including
     * the Latitude and Longitude of the Lower Left point and Upper Right
     * point of the box.
     *
     * <p> The query will block and returned values will be obtained by means of a network lookup.
     * The results are a best guess and are not guaranteed to be meaningful or
     * correct. It may be useful to call this method from a thread separate from your
     * primary UI thread.
     *
     * @param locationName a user-supplied description of a location
     * @param maxResults max number of addresses to return. Smaller numbers (1 to 5) are recommended
     * @param lowerLeftLatitude the latitude of the lower left corner of the bounding box
     * @param lowerLeftLongitude the longitude of the lower left corner of the bounding box
     * @param upperRightLatitude the latitude of the upper right corner of the bounding box
     * @param upperRightLongitude the longitude of the upper right corner of the bounding box
     *
     * @return a list of Address objects. Returns null or empty list if no matches were
     * found or there is no backend service available.
     *
     * @throws IllegalArgumentException if locationName is null
     * @throws IllegalArgumentException if any latitude is
     * less than -90 or greater than 90
     * @throws IllegalArgumentException if any longitude is
     * less than -180 or greater than 180
     * @throws IOException if the network is unavailable or any other
     * I/O problem occurs
     */
    public List<Address> getFromLocationName(String locationName, int maxResults,
        double lowerLeftLatitude, double lowerLeftLongitude,
        double upperRightLatitude, double upperRightLongitude) throws IOException {
        if (locationName == null) {
            throw new IllegalArgumentException("locationName == null");
        }
        if (lowerLeftLatitude < -90.0 || lowerLeftLatitude > 90.0) {
            throw new IllegalArgumentException("lowerLeftLatitude == "
                + lowerLeftLatitude);
        }
        if (lowerLeftLongitude < -180.0 || lowerLeftLongitude > 180.0) {
            throw new IllegalArgumentException("lowerLeftLongitude == "
                + lowerLeftLongitude);
        }
        if (upperRightLatitude < -90.0 || upperRightLatitude > 90.0) {
            throw new IllegalArgumentException("upperRightLatitude == "
                + upperRightLatitude);
        }
        if (upperRightLongitude < -180.0 || upperRightLongitude > 180.0) {
            throw new IllegalArgumentException("upperRightLongitude == "
                + upperRightLongitude);
        }
        try {
            ArrayList<Address> result = new ArrayList<Address>();
            String ex =  mService.getFromLocationName(locationName,
                lowerLeftLatitude, lowerLeftLongitude, upperRightLatitude, upperRightLongitude,
                maxResults, mParams, result);
            if (ex != null) {
                throw new IOException(ex);
            } else {
                return result;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getFromLocationName: got RemoteException", e);
            return null;
        }
    }


Number 325:
API Relative Path:
src.android.location.Geocoder.java-getFromLocationName(String-int-double-double-double-double)
Corresponding Source:
/**
     * Returns an array of Addresses that are known to describe the
     * named location, which may be a place name such as "Dalvik,
     * Iceland", an address such as "1600 Amphitheatre Parkway,
     * Mountain View, CA", an airport code such as "SFO", etc..  The
     * returned addresses will be localized for the locale provided to
     * this class's constructor.
     *
     * <p> You may specify a bounding box for the search results by including
     * the Latitude and Longitude of the Lower Left point and Upper Right
     * point of the box.
     *
     * <p> The query will block and returned values will be obtained by means of a network lookup.
     * The results are a best guess and are not guaranteed to be meaningful or
     * correct. It may be useful to call this method from a thread separate from your
     * primary UI thread.
     *
     * @param locationName a user-supplied description of a location
     * @param maxResults max number of addresses to return. Smaller numbers (1 to 5) are recommended
     * @param lowerLeftLatitude the latitude of the lower left corner of the bounding box
     * @param lowerLeftLongitude the longitude of the lower left corner of the bounding box
     * @param upperRightLatitude the latitude of the upper right corner of the bounding box
     * @param upperRightLongitude the longitude of the upper right corner of the bounding box
     *
     * @return a list of Address objects. Returns null or empty list if no matches were
     * found or there is no backend service available.
     *
     * @throws IllegalArgumentException if locationName is null
     * @throws IllegalArgumentException if any latitude is
     * less than -90 or greater than 90
     * @throws IllegalArgumentException if any longitude is
     * less than -180 or greater than 180
     * @throws IOException if the network is unavailable or any other
     * I/O problem occurs
     */
    public List<Address> getFromLocationName(String locationName, int maxResults,
        double lowerLeftLatitude, double lowerLeftLongitude,
        double upperRightLatitude, double upperRightLongitude) throws IOException {
        if (locationName == null) {
            throw new IllegalArgumentException("locationName == null");
        }
        if (lowerLeftLatitude < -90.0 || lowerLeftLatitude > 90.0) {
            throw new IllegalArgumentException("lowerLeftLatitude == "
                + lowerLeftLatitude);
        }
        if (lowerLeftLongitude < -180.0 || lowerLeftLongitude > 180.0) {
            throw new IllegalArgumentException("lowerLeftLongitude == "
                + lowerLeftLongitude);
        }
        if (upperRightLatitude < -90.0 || upperRightLatitude > 90.0) {
            throw new IllegalArgumentException("upperRightLatitude == "
                + upperRightLatitude);
        }
        if (upperRightLongitude < -180.0 || upperRightLongitude > 180.0) {
            throw new IllegalArgumentException("upperRightLongitude == "
                + upperRightLongitude);
        }
        try {
            ArrayList<Address> result = new ArrayList<Address>();
            String ex =  mService.getFromLocationName(locationName,
                lowerLeftLatitude, lowerLeftLongitude, upperRightLatitude, upperRightLongitude,
                maxResults, mParams, result);
            if (ex != null) {
                throw new IOException(ex);
            } else {
                return result;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getFromLocationName: got RemoteException", e);
            return null;
        }
    }


Number 326:
API Relative Path:
src.android.location.Geocoder.java-getFromLocationName(String-int-double-double-double-double)
Corresponding Source:
/**
     * Returns an array of Addresses that are known to describe the
     * named location, which may be a place name such as "Dalvik,
     * Iceland", an address such as "1600 Amphitheatre Parkway,
     * Mountain View, CA", an airport code such as "SFO", etc..  The
     * returned addresses will be localized for the locale provided to
     * this class's constructor.
     *
     * <p> You may specify a bounding box for the search results by including
     * the Latitude and Longitude of the Lower Left point and Upper Right
     * point of the box.
     *
     * <p> The query will block and returned values will be obtained by means of a network lookup.
     * The results are a best guess and are not guaranteed to be meaningful or
     * correct. It may be useful to call this method from a thread separate from your
     * primary UI thread.
     *
     * @param locationName a user-supplied description of a location
     * @param maxResults max number of addresses to return. Smaller numbers (1 to 5) are recommended
     * @param lowerLeftLatitude the latitude of the lower left corner of the bounding box
     * @param lowerLeftLongitude the longitude of the lower left corner of the bounding box
     * @param upperRightLatitude the latitude of the upper right corner of the bounding box
     * @param upperRightLongitude the longitude of the upper right corner of the bounding box
     *
     * @return a list of Address objects. Returns null or empty list if no matches were
     * found or there is no backend service available.
     *
     * @throws IllegalArgumentException if locationName is null
     * @throws IllegalArgumentException if any latitude is
     * less than -90 or greater than 90
     * @throws IllegalArgumentException if any longitude is
     * less than -180 or greater than 180
     * @throws IOException if the network is unavailable or any other
     * I/O problem occurs
     */
    public List<Address> getFromLocationName(String locationName, int maxResults,
        double lowerLeftLatitude, double lowerLeftLongitude,
        double upperRightLatitude, double upperRightLongitude) throws IOException {
        if (locationName == null) {
            throw new IllegalArgumentException("locationName == null");
        }
        if (lowerLeftLatitude < -90.0 || lowerLeftLatitude > 90.0) {
            throw new IllegalArgumentException("lowerLeftLatitude == "
                + lowerLeftLatitude);
        }
        if (lowerLeftLongitude < -180.0 || lowerLeftLongitude > 180.0) {
            throw new IllegalArgumentException("lowerLeftLongitude == "
                + lowerLeftLongitude);
        }
        if (upperRightLatitude < -90.0 || upperRightLatitude > 90.0) {
            throw new IllegalArgumentException("upperRightLatitude == "
                + upperRightLatitude);
        }
        if (upperRightLongitude < -180.0 || upperRightLongitude > 180.0) {
            throw new IllegalArgumentException("upperRightLongitude == "
                + upperRightLongitude);
        }
        try {
            ArrayList<Address> result = new ArrayList<Address>();
            String ex =  mService.getFromLocationName(locationName,
                lowerLeftLatitude, lowerLeftLongitude, upperRightLatitude, upperRightLongitude,
                maxResults, mParams, result);
            if (ex != null) {
                throw new IOException(ex);
            } else {
                return result;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getFromLocationName: got RemoteException", e);
            return null;
        }
    }


Number 327:
API Relative Path:
src.android.location.Geocoder.java-getFromLocationName(String-int-double-double-double-double)
Corresponding Source:
/**
     * Returns an array of Addresses that are known to describe the
     * named location, which may be a place name such as "Dalvik,
     * Iceland", an address such as "1600 Amphitheatre Parkway,
     * Mountain View, CA", an airport code such as "SFO", etc..  The
     * returned addresses will be localized for the locale provided to
     * this class's constructor.
     *
     * <p> You may specify a bounding box for the search results by including
     * the Latitude and Longitude of the Lower Left point and Upper Right
     * point of the box.
     *
     * <p> The query will block and returned values will be obtained by means of a network lookup.
     * The results are a best guess and are not guaranteed to be meaningful or
     * correct. It may be useful to call this method from a thread separate from your
     * primary UI thread.
     *
     * @param locationName a user-supplied description of a location
     * @param maxResults max number of addresses to return. Smaller numbers (1 to 5) are recommended
     * @param lowerLeftLatitude the latitude of the lower left corner of the bounding box
     * @param lowerLeftLongitude the longitude of the lower left corner of the bounding box
     * @param upperRightLatitude the latitude of the upper right corner of the bounding box
     * @param upperRightLongitude the longitude of the upper right corner of the bounding box
     *
     * @return a list of Address objects. Returns null or empty list if no matches were
     * found or there is no backend service available.
     *
     * @throws IllegalArgumentException if locationName is null
     * @throws IllegalArgumentException if any latitude is
     * less than -90 or greater than 90
     * @throws IllegalArgumentException if any longitude is
     * less than -180 or greater than 180
     * @throws IOException if the network is unavailable or any other
     * I/O problem occurs
     */
    public List<Address> getFromLocationName(String locationName, int maxResults,
        double lowerLeftLatitude, double lowerLeftLongitude,
        double upperRightLatitude, double upperRightLongitude) throws IOException {
        if (locationName == null) {
            throw new IllegalArgumentException("locationName == null");
        }
        if (lowerLeftLatitude < -90.0 || lowerLeftLatitude > 90.0) {
            throw new IllegalArgumentException("lowerLeftLatitude == "
                + lowerLeftLatitude);
        }
        if (lowerLeftLongitude < -180.0 || lowerLeftLongitude > 180.0) {
            throw new IllegalArgumentException("lowerLeftLongitude == "
                + lowerLeftLongitude);
        }
        if (upperRightLatitude < -90.0 || upperRightLatitude > 90.0) {
            throw new IllegalArgumentException("upperRightLatitude == "
                + upperRightLatitude);
        }
        if (upperRightLongitude < -180.0 || upperRightLongitude > 180.0) {
            throw new IllegalArgumentException("upperRightLongitude == "
                + upperRightLongitude);
        }
        try {
            ArrayList<Address> result = new ArrayList<Address>();
            String ex =  mService.getFromLocationName(locationName,
                lowerLeftLatitude, lowerLeftLongitude, upperRightLatitude, upperRightLongitude,
                maxResults, mParams, result);
            if (ex != null) {
                throw new IOException(ex);
            } else {
                return result;
            }
        } catch (RemoteException e) {
            Log.e(TAG, "getFromLocationName: got RemoteException", e);
            return null;
        }
    }


Number 328:
API Relative Path:
src.android.location.GnssMeasurementsEvent.java-GnssMeasurementsEvent(GnssClock-GnssMeasurement[])
Corresponding Source:
/**
     * @hide
     */
    @TestApi
    public GnssMeasurementsEvent(GnssClock clock, GnssMeasurement[] measurements) {
        if (clock == null) {
            throw new InvalidParameterException("Parameter 'clock' must not be null.");
        }
        if (measurements == null || measurements.length == 0) {
            throw new InvalidParameterException(
                    "Parameter 'measurements' must not be null or empty.");
        }

        mClock = clock;
        Collection<GnssMeasurement> measurementCollection = Arrays.asList(measurements);
        mReadOnlyMeasurements = Collections.unmodifiableCollection(measurementCollection);
    }


Number 329:
API Relative Path:
src.android.location.GnssMeasurementsEvent.java-GnssMeasurementsEvent(GnssClock-GnssMeasurement[])
Corresponding Source:
/**
     * @hide
     */
    @TestApi
    public GnssMeasurementsEvent(GnssClock clock, GnssMeasurement[] measurements) {
        if (clock == null) {
            throw new InvalidParameterException("Parameter 'clock' must not be null.");
        }
        if (measurements == null || measurements.length == 0) {
            throw new InvalidParameterException(
                    "Parameter 'measurements' must not be null or empty.");
        }

        mClock = clock;
        Collection<GnssMeasurement> measurementCollection = Arrays.asList(measurements);
        mReadOnlyMeasurements = Collections.unmodifiableCollection(measurementCollection);
    }


Number 330:
API Relative Path:
src.android.location.GnssNavigationMessage.java-setData(byte[])
Corresponding Source:
/**
     * Sets the data associated with the Navigation Message.
     * @hide
     */
    @TestApi
    public void setData(byte[] value) {
        if (value == null) {
            throw new InvalidParameterException("Data must be a non-null array");
        }

        mData = value;
    }


Number 331:
API Relative Path:
src.android.location.GpsNavigationMessage.java-setData(byte[])
Corresponding Source:
/**
     * Sets the data associated with the Navigation Message.
     */
    public void setData(byte[] value) {
        if (value == null) {
            throw new InvalidParameterException("Data must be a non-null array");
        }

        mData = value;
    }


Number 332:
API Relative Path:
src.android.location.Location.java-convert(double-int)
Corresponding Source:
/**
     * Converts a coordinate to a String representation. The outputType
     * may be one of FORMAT_DEGREES, FORMAT_MINUTES, or FORMAT_SECONDS.
     * The coordinate must be a valid double between -180.0 and 180.0.
     * This conversion is performed in a method that is dependent on the
     * default locale, and so is not guaranteed to round-trip with
     * {@link #convert(String)}.
     *
     * @throws IllegalArgumentException if coordinate is less than
     * -180.0, greater than 180.0, or is not a number.
     * @throws IllegalArgumentException if outputType is not one of
     * FORMAT_DEGREES, FORMAT_MINUTES, or FORMAT_SECONDS.
     */
    public static String convert(double coordinate, int outputType) {
        if (coordinate < -180.0 || coordinate > 180.0 ||
            Double.isNaN(coordinate)) {
            throw new IllegalArgumentException("coordinate=" + coordinate);
        }
        if ((outputType != FORMAT_DEGREES) &&
            (outputType != FORMAT_MINUTES) &&
            (outputType != FORMAT_SECONDS)) {
            throw new IllegalArgumentException("outputType=" + outputType);
        }

        StringBuilder sb = new StringBuilder();

        // Handle negative values
        if (coordinate < 0) {
            sb.append('-');
            coordinate = -coordinate;
        }

        DecimalFormat df = new DecimalFormat("###.#####");
        if (outputType == FORMAT_MINUTES || outputType == FORMAT_SECONDS) {
            int degrees = (int) Math.floor(coordinate);
            sb.append(degrees);
            sb.append(':');
            coordinate -= degrees;
            coordinate *= 60.0;
            if (outputType == FORMAT_SECONDS) {
                int minutes = (int) Math.floor(coordinate);
                sb.append(minutes);
                sb.append(':');
                coordinate -= minutes;
                coordinate *= 60.0;
            }
        }
        sb.append(df.format(coordinate));
        return sb.toString();
    }


Number 333:
API Relative Path:
src.android.location.LocationRequest.java-setNumUpdates(int)
Corresponding Source:
/**
     * Set the number of location updates.
     *
     * <p>By default locations are continuously updated until the request is explicitly
     * removed, however you can optionally request a set number of updates.
     * For example, if your application only needs a single fresh location,
     * then call this method with a value of 1 before passing the request
     * to the location manager.
     *
     * @param numUpdates the number of location updates requested
     * @throws InvalidArgumentException if numUpdates is 0 or less
     * @return the same object, so that setters can be chained
     */
    public LocationRequest setNumUpdates(int numUpdates) {
        if (numUpdates <= 0) throw new IllegalArgumentException("invalid numUpdates: " + numUpdates);
        mNumUpdates = numUpdates;
        return this;
    }


Number 334:
API Relative Path:
src.android.media.AsyncPlayer.java-play(Context-Uri-boolean-AudioAttributes)
Corresponding Source:
/**
     * Start playing the sound.  It will actually start playing at some
     * point in the future.  There are no guarantees about latency here.
     * Calling this before another audio file is done playing will stop
     * that one and start the new one.
     *
     * @param context the non-null application's context.
     * @param uri the non-null URI to play.  (see {@link MediaPlayer#setDataSource(Context, Uri)})
     * @param looping whether the audio should loop forever.
     *          (see {@link MediaPlayer#setLooping(boolean)})
     * @param attributes the non-null {@link AudioAttributes} to use.
     *          (see {@link MediaPlayer#setAudioAttributes(AudioAttributes)})
     * @throws IllegalArgumentException
     */
    public void play(@NonNull Context context, @NonNull Uri uri, boolean looping,
            @NonNull AudioAttributes attributes) throws IllegalArgumentException {
        if (context == null || uri == null || attributes == null) {
            throw new IllegalArgumentException("Illegal null AsyncPlayer.play() argument");
        }
        Command cmd = new Command();
        cmd.requestTime = SystemClock.uptimeMillis();
        cmd.code = PLAY;
        cmd.context = context;
        cmd.uri = uri;
        cmd.looping = looping;
        cmd.attributes = attributes;
        synchronized (mCmdQueue) {
            enqueueLocked(cmd);
            mState = PLAY;
        }
    }


Number 335:
API Relative Path:
src.android.media.AsyncPlayer.java-play(Context-Uri-boolean-int)
Corresponding Source:
/**
     * Start playing the sound.  It will actually start playing at some
     * point in the future.  There are no guarantees about latency here.
     * Calling this before another audio file is done playing will stop
     * that one and start the new one.
     *
     * @param context Your application's context.
     * @param uri The URI to play.  (see {@link MediaPlayer#setDataSource(Context, Uri)})
     * @param looping Whether the audio should loop forever.  
     *          (see {@link MediaPlayer#setLooping(boolean)})
     * @param stream the AudioStream to use.
     *          (see {@link MediaPlayer#setAudioStreamType(int)})
     * @deprecated use {@link #play(Context, Uri, boolean, AudioAttributes)} instead
     */
    public void play(Context context, Uri uri, boolean looping, int stream) {
        if (context == null || uri == null) {
            return;
        }
        try {
            play(context, uri, looping,
                    new AudioAttributes.Builder().setInternalLegacyStreamType(stream).build());
        } catch (IllegalArgumentException e) {
            Log.e(mTag, "Call to deprecated AsyncPlayer.play() method caused:", e);
        }
    }


Number 336:
API Relative Path:
src.android.media.AudioFormat.java-filterPublicFormats(int[])
Corresponding Source:
/**
     * Returns an array of public encoding values extracted from an array of
     * encoding values.
     * @hide
     */
    public static int[] filterPublicFormats(int[] formats) {
        if (formats == null) {
            return null;
        }
        int[] myCopy = Arrays.copyOf(formats, formats.length);
        int size = 0;
        for (int i = 0; i < myCopy.length; i++) {
            if (isPublicEncoding(myCopy[i])) {
                if (size != i) {
                    myCopy[size] = myCopy[i];
                }
                size++;
            }
        }
        return Arrays.copyOf(myCopy, size);
    }


Number 337:
API Relative Path:
src.android.media.AudioFormat.java-inChannelMaskFromOutChannelMask(int)
Corresponding Source:
/**
     * @hide
     * Return the input channel mask corresponding to an output channel mask.
     * This can be used for submix rerouting for the mask of the recorder to map to that of the mix.
     * @param outMask a combination of the CHANNEL_OUT_* definitions, but not CHANNEL_OUT_DEFAULT
     * @return a combination of CHANNEL_IN_* definitions matching an output channel mask
     * @throws IllegalArgumentException
     */
    public static int inChannelMaskFromOutChannelMask(int outMask) throws IllegalArgumentException {
        if (outMask == CHANNEL_OUT_DEFAULT) {
            throw new IllegalArgumentException(
                    "Illegal CHANNEL_OUT_DEFAULT channel mask for input.");
        }
        switch (channelCountFromOutChannelMask(outMask)) {
            case 1:
                return CHANNEL_IN_MONO;
            case 2:
                return CHANNEL_IN_STEREO;
            default:
                throw new IllegalArgumentException("Unsupported channel configuration for input.");
        }
    }


Number 338:
API Relative Path:
src.android.media.AudioManager.java-registerMediaButtonEventReceiver(ComponentName)
Corresponding Source:
/**
     * Unregister the receiver of MEDIA_BUTTON intents.
     * @param eventReceiver identifier of a {@link android.content.BroadcastReceiver}
     *      that was registered with {@link #registerMediaButtonEventReceiver(ComponentName)}.
     * @deprecated Use {@link MediaSession} instead.
     */
    @Deprecated
    public void unregisterMediaButtonEventReceiver(ComponentName eventReceiver) {
        if (eventReceiver == null) {
            return;
        }
        // construct a PendingIntent for the media button and unregister it
        Intent mediaButtonIntent = new Intent(Intent.ACTION_MEDIA_BUTTON);
        //     the associated intent will be handled by the component being registered
        mediaButtonIntent.setComponent(eventReceiver);
        PendingIntent pi = PendingIntent.getBroadcast(getContext(),
                0/*requestCode, ignored*/, mediaButtonIntent, 0/*flags*/);
        unregisterMediaButtonIntent(pi);
    }


Number 339:
API Relative Path:
src.android.media.AudioManager.java-registerMediaButtonEventReceiver(PendingIntent)
Corresponding Source:
/**
     * Unregister the receiver of MEDIA_BUTTON intents.
     * @param eventReceiver same PendingIntent that was registed with
     *      {@link #registerMediaButtonEventReceiver(PendingIntent)}.
     * @deprecated Use {@link MediaSession} instead.
     */
    @Deprecated
    public void unregisterMediaButtonEventReceiver(PendingIntent eventReceiver) {
        if (eventReceiver == null) {
            return;
        }
        unregisterMediaButtonIntent(eventReceiver);
    }


Number 340:
API Relative Path:
src.android.media.AudioManager.java-registerRemoteControlClient(RemoteControlClient)
Corresponding Source:
/**
     * Unregisters the remote control client that was providing information to display on the
     * remote controls.
     * @param rcClient The remote control client to unregister.
     * @see #registerRemoteControlClient(RemoteControlClient)
     * @deprecated Use {@link MediaSession} instead.
     */
    @Deprecated
    public void unregisterRemoteControlClient(RemoteControlClient rcClient) {
        if ((rcClient == null) || (rcClient.getRcMediaIntent() == null)) {
            return;
        }
        rcClient.unregisterWithSession(MediaSessionLegacyHelper.getHelper(getContext()));
    }


Number 341:
API Relative Path:
src.android.media.AudioManager.java-requestAudioFocus(OnAudioFocusChangeListener-AudioAttributes-int-int)
Corresponding Source:
/**
     * @hide
     * Request audio focus.
     * Send a request to obtain the audio focus. This method differs from
     * {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)} in that it can express
     * that the requester accepts delayed grants of audio focus.
     * @param l the listener to be notified of audio focus changes. It is not allowed to be null
     *     when the request is flagged with {@link #AUDIOFOCUS_FLAG_DELAY_OK}.
     * @param requestAttributes non null {@link AudioAttributes} describing the main reason for
     *     requesting audio focus.
     * @param durationHint use {@link #AUDIOFOCUS_GAIN_TRANSIENT} to indicate this focus request
     *      is temporary, and focus will be abandonned shortly. Examples of transient requests are
     *      for the playback of driving directions, or notifications sounds.
     *      Use {@link #AUDIOFOCUS_GAIN_TRANSIENT_MAY_DUCK} to indicate also that it's ok for
     *      the previous focus owner to keep playing if it ducks its audio output.
     *      Alternatively use {@link #AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE} for a temporary request
     *      that benefits from the system not playing disruptive sounds like notifications, for
     *      usecases such as voice memo recording, or speech recognition.
     *      Use {@link #AUDIOFOCUS_GAIN} for a focus request of unknown duration such
     *      as the playback of a song or a video.
     * @param flags 0 or a combination of {link #AUDIOFOCUS_FLAG_DELAY_OK}
     *     and {@link #AUDIOFOCUS_FLAG_PAUSES_ON_DUCKABLE_LOSS}.
     *     <br>Use 0 when not using any flags for the request, which behaves like
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)}, where either audio
     *     focus is granted immediately, or the grant request fails because the system is in a
     *     state where focus cannot change (e.g. a phone call).
     * @return {@link #AUDIOFOCUS_REQUEST_FAILED}, {@link #AUDIOFOCUS_REQUEST_GRANTED}
     *     or {@link #AUDIOFOCUS_REQUEST_DELAYED}.
     *     The return value is never {@link #AUDIOFOCUS_REQUEST_DELAYED} when focus is requested
     *     without the {@link #AUDIOFOCUS_FLAG_DELAY_OK} flag.
     * @throws IllegalArgumentException
     */
    @SystemApi
    public int requestAudioFocus(OnAudioFocusChangeListener l,
            @NonNull AudioAttributes requestAttributes,
            int durationHint,
            int flags) throws IllegalArgumentException {
        if (flags != (flags & AUDIOFOCUS_FLAGS_APPS)) {
            throw new IllegalArgumentException("Invalid flags 0x"
                    + Integer.toHexString(flags).toUpperCase());
        }
        return requestAudioFocus(l, requestAttributes, durationHint,
                flags & AUDIOFOCUS_FLAGS_APPS,
                null /* no AudioPolicy*/);
    }


Number 342:
API Relative Path:
src.android.media.AudioManager.java-requestAudioFocus(OnAudioFocusChangeListener-AudioAttributes-int-int-AudioPolicy)
Corresponding Source:
/**
     * @hide
     * Request or lock audio focus.
     * This method is to be used by system components that have registered an
     * {@link android.media.audiopolicy.AudioPolicy} to request audio focus, but also to "lock" it
     * so focus granting is temporarily disabled.
     * @param l see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param requestAttributes non null {@link AudioAttributes} describing the main reason for
     *     requesting audio focus.
     * @param durationHint see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param flags 0 or a combination of {link #AUDIOFOCUS_FLAG_DELAY_OK},
     *     {@link #AUDIOFOCUS_FLAG_PAUSES_ON_DUCKABLE_LOSS}, and {@link #AUDIOFOCUS_FLAG_LOCK}.
     *     <br>Use 0 when not using any flags for the request, which behaves like
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)}, where either audio
     *     focus is granted immediately, or the grant request fails because the system is in a
     *     state where focus cannot change (e.g. a phone call).
     * @param ap a registered {@link android.media.audiopolicy.AudioPolicy} instance when locking
     *     focus, or null.
     * @return see the description of the same return value in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @throws IllegalArgumentException
     */
    @SystemApi
    public int requestAudioFocus(OnAudioFocusChangeListener l,
            @NonNull AudioAttributes requestAttributes,
            int durationHint,
            int flags,
            AudioPolicy ap) throws IllegalArgumentException {
        // parameter checking
        if (requestAttributes == null) {
            throw new IllegalArgumentException("Illegal null AudioAttributes argument");
        }
        if ((durationHint < AUDIOFOCUS_GAIN) ||
                (durationHint > AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)) {
            throw new IllegalArgumentException("Invalid duration hint");
        }
        if (flags != (flags & AUDIOFOCUS_FLAGS_SYSTEM)) {
            throw new IllegalArgumentException("Illegal flags 0x"
                + Integer.toHexString(flags).toUpperCase());
        }
        if (((flags & AUDIOFOCUS_FLAG_DELAY_OK) == AUDIOFOCUS_FLAG_DELAY_OK) && (l == null)) {
            throw new IllegalArgumentException(
                    "Illegal null focus listener when flagged as accepting delayed focus grant");
        }
        if (((flags & AUDIOFOCUS_FLAG_LOCK) == AUDIOFOCUS_FLAG_LOCK) && (ap == null)) {
            throw new IllegalArgumentException(
                    "Illegal null audio policy when locking audio focus");
        }

        int status = AUDIOFOCUS_REQUEST_FAILED;
        registerAudioFocusListener(l);
        IAudioService service = getService();
        try {
            status = service.requestAudioFocus(requestAttributes, durationHint, mICallBack,
                    mAudioFocusDispatcher, getIdForAudioFocusListener(l),
                    getContext().getOpPackageName() /* package name */, flags,
                    ap != null ? ap.cb() : null);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
        return status;
    }


Number 343:
API Relative Path:
src.android.media.AudioManager.java-requestAudioFocus(OnAudioFocusChangeListener-AudioAttributes-int-int-AudioPolicy)
Corresponding Source:
/**
     * @hide
     * Request or lock audio focus.
     * This method is to be used by system components that have registered an
     * {@link android.media.audiopolicy.AudioPolicy} to request audio focus, but also to "lock" it
     * so focus granting is temporarily disabled.
     * @param l see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param requestAttributes non null {@link AudioAttributes} describing the main reason for
     *     requesting audio focus.
     * @param durationHint see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param flags 0 or a combination of {link #AUDIOFOCUS_FLAG_DELAY_OK},
     *     {@link #AUDIOFOCUS_FLAG_PAUSES_ON_DUCKABLE_LOSS}, and {@link #AUDIOFOCUS_FLAG_LOCK}.
     *     <br>Use 0 when not using any flags for the request, which behaves like
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)}, where either audio
     *     focus is granted immediately, or the grant request fails because the system is in a
     *     state where focus cannot change (e.g. a phone call).
     * @param ap a registered {@link android.media.audiopolicy.AudioPolicy} instance when locking
     *     focus, or null.
     * @return see the description of the same return value in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @throws IllegalArgumentException
     */
    @SystemApi
    public int requestAudioFocus(OnAudioFocusChangeListener l,
            @NonNull AudioAttributes requestAttributes,
            int durationHint,
            int flags,
            AudioPolicy ap) throws IllegalArgumentException {
        // parameter checking
        if (requestAttributes == null) {
            throw new IllegalArgumentException("Illegal null AudioAttributes argument");
        }
        if ((durationHint < AUDIOFOCUS_GAIN) ||
                (durationHint > AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)) {
            throw new IllegalArgumentException("Invalid duration hint");
        }
        if (flags != (flags & AUDIOFOCUS_FLAGS_SYSTEM)) {
            throw new IllegalArgumentException("Illegal flags 0x"
                + Integer.toHexString(flags).toUpperCase());
        }
        if (((flags & AUDIOFOCUS_FLAG_DELAY_OK) == AUDIOFOCUS_FLAG_DELAY_OK) && (l == null)) {
            throw new IllegalArgumentException(
                    "Illegal null focus listener when flagged as accepting delayed focus grant");
        }
        if (((flags & AUDIOFOCUS_FLAG_LOCK) == AUDIOFOCUS_FLAG_LOCK) && (ap == null)) {
            throw new IllegalArgumentException(
                    "Illegal null audio policy when locking audio focus");
        }

        int status = AUDIOFOCUS_REQUEST_FAILED;
        registerAudioFocusListener(l);
        IAudioService service = getService();
        try {
            status = service.requestAudioFocus(requestAttributes, durationHint, mICallBack,
                    mAudioFocusDispatcher, getIdForAudioFocusListener(l),
                    getContext().getOpPackageName() /* package name */, flags,
                    ap != null ? ap.cb() : null);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
        return status;
    }


Number 344:
API Relative Path:
src.android.media.AudioManager.java-requestAudioFocus(OnAudioFocusChangeListener-AudioAttributes-int-int-AudioPolicy)
Corresponding Source:
/**
     * @hide
     * Request or lock audio focus.
     * This method is to be used by system components that have registered an
     * {@link android.media.audiopolicy.AudioPolicy} to request audio focus, but also to "lock" it
     * so focus granting is temporarily disabled.
     * @param l see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param requestAttributes non null {@link AudioAttributes} describing the main reason for
     *     requesting audio focus.
     * @param durationHint see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param flags 0 or a combination of {link #AUDIOFOCUS_FLAG_DELAY_OK},
     *     {@link #AUDIOFOCUS_FLAG_PAUSES_ON_DUCKABLE_LOSS}, and {@link #AUDIOFOCUS_FLAG_LOCK}.
     *     <br>Use 0 when not using any flags for the request, which behaves like
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)}, where either audio
     *     focus is granted immediately, or the grant request fails because the system is in a
     *     state where focus cannot change (e.g. a phone call).
     * @param ap a registered {@link android.media.audiopolicy.AudioPolicy} instance when locking
     *     focus, or null.
     * @return see the description of the same return value in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @throws IllegalArgumentException
     */
    @SystemApi
    public int requestAudioFocus(OnAudioFocusChangeListener l,
            @NonNull AudioAttributes requestAttributes,
            int durationHint,
            int flags,
            AudioPolicy ap) throws IllegalArgumentException {
        // parameter checking
        if (requestAttributes == null) {
            throw new IllegalArgumentException("Illegal null AudioAttributes argument");
        }
        if ((durationHint < AUDIOFOCUS_GAIN) ||
                (durationHint > AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)) {
            throw new IllegalArgumentException("Invalid duration hint");
        }
        if (flags != (flags & AUDIOFOCUS_FLAGS_SYSTEM)) {
            throw new IllegalArgumentException("Illegal flags 0x"
                + Integer.toHexString(flags).toUpperCase());
        }
        if (((flags & AUDIOFOCUS_FLAG_DELAY_OK) == AUDIOFOCUS_FLAG_DELAY_OK) && (l == null)) {
            throw new IllegalArgumentException(
                    "Illegal null focus listener when flagged as accepting delayed focus grant");
        }
        if (((flags & AUDIOFOCUS_FLAG_LOCK) == AUDIOFOCUS_FLAG_LOCK) && (ap == null)) {
            throw new IllegalArgumentException(
                    "Illegal null audio policy when locking audio focus");
        }

        int status = AUDIOFOCUS_REQUEST_FAILED;
        registerAudioFocusListener(l);
        IAudioService service = getService();
        try {
            status = service.requestAudioFocus(requestAttributes, durationHint, mICallBack,
                    mAudioFocusDispatcher, getIdForAudioFocusListener(l),
                    getContext().getOpPackageName() /* package name */, flags,
                    ap != null ? ap.cb() : null);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
        return status;
    }


Number 345:
API Relative Path:
src.android.media.AudioManager.java-requestAudioFocus(OnAudioFocusChangeListener-AudioAttributes-int-int-AudioPolicy)
Corresponding Source:
/**
     * @hide
     * Request or lock audio focus.
     * This method is to be used by system components that have registered an
     * {@link android.media.audiopolicy.AudioPolicy} to request audio focus, but also to "lock" it
     * so focus granting is temporarily disabled.
     * @param l see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param requestAttributes non null {@link AudioAttributes} describing the main reason for
     *     requesting audio focus.
     * @param durationHint see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param flags 0 or a combination of {link #AUDIOFOCUS_FLAG_DELAY_OK},
     *     {@link #AUDIOFOCUS_FLAG_PAUSES_ON_DUCKABLE_LOSS}, and {@link #AUDIOFOCUS_FLAG_LOCK}.
     *     <br>Use 0 when not using any flags for the request, which behaves like
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)}, where either audio
     *     focus is granted immediately, or the grant request fails because the system is in a
     *     state where focus cannot change (e.g. a phone call).
     * @param ap a registered {@link android.media.audiopolicy.AudioPolicy} instance when locking
     *     focus, or null.
     * @return see the description of the same return value in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @throws IllegalArgumentException
     */
    @SystemApi
    public int requestAudioFocus(OnAudioFocusChangeListener l,
            @NonNull AudioAttributes requestAttributes,
            int durationHint,
            int flags,
            AudioPolicy ap) throws IllegalArgumentException {
        // parameter checking
        if (requestAttributes == null) {
            throw new IllegalArgumentException("Illegal null AudioAttributes argument");
        }
        if ((durationHint < AUDIOFOCUS_GAIN) ||
                (durationHint > AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)) {
            throw new IllegalArgumentException("Invalid duration hint");
        }
        if (flags != (flags & AUDIOFOCUS_FLAGS_SYSTEM)) {
            throw new IllegalArgumentException("Illegal flags 0x"
                + Integer.toHexString(flags).toUpperCase());
        }
        if (((flags & AUDIOFOCUS_FLAG_DELAY_OK) == AUDIOFOCUS_FLAG_DELAY_OK) && (l == null)) {
            throw new IllegalArgumentException(
                    "Illegal null focus listener when flagged as accepting delayed focus grant");
        }
        if (((flags & AUDIOFOCUS_FLAG_LOCK) == AUDIOFOCUS_FLAG_LOCK) && (ap == null)) {
            throw new IllegalArgumentException(
                    "Illegal null audio policy when locking audio focus");
        }

        int status = AUDIOFOCUS_REQUEST_FAILED;
        registerAudioFocusListener(l);
        IAudioService service = getService();
        try {
            status = service.requestAudioFocus(requestAttributes, durationHint, mICallBack,
                    mAudioFocusDispatcher, getIdForAudioFocusListener(l),
                    getContext().getOpPackageName() /* package name */, flags,
                    ap != null ? ap.cb() : null);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
        return status;
    }


Number 346:
API Relative Path:
src.android.media.AudioManager.java-requestAudioFocus(OnAudioFocusChangeListener-AudioAttributes-int-int-AudioPolicy)
Corresponding Source:
/**
     * @hide
     * Request or lock audio focus.
     * This method is to be used by system components that have registered an
     * {@link android.media.audiopolicy.AudioPolicy} to request audio focus, but also to "lock" it
     * so focus granting is temporarily disabled.
     * @param l see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param requestAttributes non null {@link AudioAttributes} describing the main reason for
     *     requesting audio focus.
     * @param durationHint see the description of the same parameter in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @param flags 0 or a combination of {link #AUDIOFOCUS_FLAG_DELAY_OK},
     *     {@link #AUDIOFOCUS_FLAG_PAUSES_ON_DUCKABLE_LOSS}, and {@link #AUDIOFOCUS_FLAG_LOCK}.
     *     <br>Use 0 when not using any flags for the request, which behaves like
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, int, int)}, where either audio
     *     focus is granted immediately, or the grant request fails because the system is in a
     *     state where focus cannot change (e.g. a phone call).
     * @param ap a registered {@link android.media.audiopolicy.AudioPolicy} instance when locking
     *     focus, or null.
     * @return see the description of the same return value in
     *     {@link #requestAudioFocus(OnAudioFocusChangeListener, AudioAttributes, int, int)}
     * @throws IllegalArgumentException
     */
    @SystemApi
    public int requestAudioFocus(OnAudioFocusChangeListener l,
            @NonNull AudioAttributes requestAttributes,
            int durationHint,
            int flags,
            AudioPolicy ap) throws IllegalArgumentException {
        // parameter checking
        if (requestAttributes == null) {
            throw new IllegalArgumentException("Illegal null AudioAttributes argument");
        }
        if ((durationHint < AUDIOFOCUS_GAIN) ||
                (durationHint > AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)) {
            throw new IllegalArgumentException("Invalid duration hint");
        }
        if (flags != (flags & AUDIOFOCUS_FLAGS_SYSTEM)) {
            throw new IllegalArgumentException("Illegal flags 0x"
                + Integer.toHexString(flags).toUpperCase());
        }
        if (((flags & AUDIOFOCUS_FLAG_DELAY_OK) == AUDIOFOCUS_FLAG_DELAY_OK) && (l == null)) {
            throw new IllegalArgumentException(
                    "Illegal null focus listener when flagged as accepting delayed focus grant");
        }
        if (((flags & AUDIOFOCUS_FLAG_LOCK) == AUDIOFOCUS_FLAG_LOCK) && (ap == null)) {
            throw new IllegalArgumentException(
                    "Illegal null audio policy when locking audio focus");
        }

        int status = AUDIOFOCUS_REQUEST_FAILED;
        registerAudioFocusListener(l);
        IAudioService service = getService();
        try {
            status = service.requestAudioFocus(requestAttributes, durationHint, mICallBack,
                    mAudioFocusDispatcher, getIdForAudioFocusListener(l),
                    getContext().getOpPackageName() /* package name */, flags,
                    ap != null ? ap.cb() : null);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
        return status;
    }


Number 347:
API Relative Path:
src.android.media.AudioManager.java-unregisterMediaButtonEventReceiver(ComponentName)
Corresponding Source:
/**
     * Unregister the receiver of MEDIA_BUTTON intents.
     * @param eventReceiver identifier of a {@link android.content.BroadcastReceiver}
     *      that was registered with {@link #registerMediaButtonEventReceiver(ComponentName)}.
     * @deprecated Use {@link MediaSession} instead.
     */
    @Deprecated
    public void unregisterMediaButtonEventReceiver(ComponentName eventReceiver) {
        if (eventReceiver == null) {
            return;
        }
        // construct a PendingIntent for the media button and unregister it
        Intent mediaButtonIntent = new Intent(Intent.ACTION_MEDIA_BUTTON);
        //     the associated intent will be handled by the component being registered
        mediaButtonIntent.setComponent(eventReceiver);
        PendingIntent pi = PendingIntent.getBroadcast(getContext(),
                0/*requestCode, ignored*/, mediaButtonIntent, 0/*flags*/);
        unregisterMediaButtonIntent(pi);
    }


Number 348:
API Relative Path:
src.android.media.AudioManager.java-unregisterMediaButtonEventReceiver(PendingIntent)
Corresponding Source:
/**
     * Unregister the receiver of MEDIA_BUTTON intents.
     * @param eventReceiver same PendingIntent that was registed with
     *      {@link #registerMediaButtonEventReceiver(PendingIntent)}.
     * @deprecated Use {@link MediaSession} instead.
     */
    @Deprecated
    public void unregisterMediaButtonEventReceiver(PendingIntent eventReceiver) {
        if (eventReceiver == null) {
            return;
        }
        unregisterMediaButtonIntent(eventReceiver);
    }


Number 349:
API Relative Path:
src.android.media.AudioManager.java-unregisterRemoteControlClient(RemoteControlClient)
Corresponding Source:
/**
     * Unregisters the remote control client that was providing information to display on the
     * remote controls.
     * @param rcClient The remote control client to unregister.
     * @see #registerRemoteControlClient(RemoteControlClient)
     * @deprecated Use {@link MediaSession} instead.
     */
    @Deprecated
    public void unregisterRemoteControlClient(RemoteControlClient rcClient) {
        if ((rcClient == null) || (rcClient.getRcMediaIntent() == null)) {
            return;
        }
        rcClient.unregisterWithSession(MediaSessionLegacyHelper.getHelper(getContext()));
    }


Number 350:
API Relative Path:
src.android.media.AudioManager.java-unregisterRemoteController(RemoteController)
Corresponding Source:
/**
     * Unregisters a {@link RemoteController}, causing it to no longer receive
     * media metadata and playback state information, and no longer be capable
     * of controlling playback.
     *
     * @param rctlr the object to unregister.
     * @deprecated Use
     *             {@link MediaSessionManager#removeOnActiveSessionsChangedListener(android.media.session.MediaSessionManager.OnActiveSessionsChangedListener)}
     *             instead.
     */
    @Deprecated
    public void unregisterRemoteController(RemoteController rctlr) {
        if (rctlr == null) {
            return;
        }
        rctlr.stopListeningToSessions();
    }


Number 351:
API Relative Path:
src.android.media.audiopolicy.AudioPolicy.java-setFocusDuckingBehavior(int)
Corresponding Source:
// Note on implementation: not part of the Builder as there can be only one registered policy
    // that handles ducking but there can be multiple policies
    /**
     * Sets the behavior for audio focus-related ducking.
     * There must be a focus listener if this policy is to handle ducking.
     * @param behavior {@link #FOCUS_POLICY_DUCKING_IN_APP} or
     *     {@link #FOCUS_POLICY_DUCKING_IN_POLICY}
     * @return {@link AudioManager#SUCCESS} or {@link AudioManager#ERROR} (for instance if there
     *     is already an audio policy that handles ducking).
     * @throws IllegalArgumentException
     * @throws IllegalStateException
     */
    @SystemApi
    public int setFocusDuckingBehavior(int behavior)
            throws IllegalArgumentException, IllegalStateException {
        if ((behavior != FOCUS_POLICY_DUCKING_IN_APP)
                && (behavior != FOCUS_POLICY_DUCKING_IN_POLICY)) {
            throw new IllegalArgumentException("Invalid ducking behavior " + behavior);
        }
        synchronized (mLock) {
            if (mStatus != POLICY_STATUS_REGISTERED) {
                throw new IllegalStateException(
                        "Cannot change ducking behavior for unregistered policy");
            }
            if ((behavior == FOCUS_POLICY_DUCKING_IN_POLICY)
                    && (mFocusListener == null)) {
                // there must be a focus listener if the policy handles ducking
                throw new IllegalStateException(
                        "Cannot handle ducking without an audio focus listener");
            }
            IAudioService service = getService();
            try {
                final int status = service.setFocusPropertiesForPolicy(behavior /*duckingBehavior*/,
                        this.cb());
                if (status == AudioManager.SUCCESS) {
                    mConfig.mDuckingPolicy = behavior;
                }
                return status;
            } catch (RemoteException e) {
                Log.e(TAG, "Dead object in setFocusPropertiesForPolicy for behavior", e);
                return AudioManager.ERROR;
            }
        }
    }


Number 352:
API Relative Path:
src.android.media.audiopolicy.AudioPolicy.java-setFocusDuckingBehavior(int)
Corresponding Source:
// Note on implementation: not part of the Builder as there can be only one registered policy
    // that handles ducking but there can be multiple policies
    /**
     * Sets the behavior for audio focus-related ducking.
     * There must be a focus listener if this policy is to handle ducking.
     * @param behavior {@link #FOCUS_POLICY_DUCKING_IN_APP} or
     *     {@link #FOCUS_POLICY_DUCKING_IN_POLICY}
     * @return {@link AudioManager#SUCCESS} or {@link AudioManager#ERROR} (for instance if there
     *     is already an audio policy that handles ducking).
     * @throws IllegalArgumentException
     * @throws IllegalStateException
     */
    @SystemApi
    public int setFocusDuckingBehavior(int behavior)
            throws IllegalArgumentException, IllegalStateException {
        if ((behavior != FOCUS_POLICY_DUCKING_IN_APP)
                && (behavior != FOCUS_POLICY_DUCKING_IN_POLICY)) {
            throw new IllegalArgumentException("Invalid ducking behavior " + behavior);
        }
        synchronized (mLock) {
            if (mStatus != POLICY_STATUS_REGISTERED) {
                throw new IllegalStateException(
                        "Cannot change ducking behavior for unregistered policy");
            }
            if ((behavior == FOCUS_POLICY_DUCKING_IN_POLICY)
                    && (mFocusListener == null)) {
                // there must be a focus listener if the policy handles ducking
                throw new IllegalStateException(
                        "Cannot handle ducking without an audio focus listener");
            }
            IAudioService service = getService();
            try {
                final int status = service.setFocusPropertiesForPolicy(behavior /*duckingBehavior*/,
                        this.cb());
                if (status == AudioManager.SUCCESS) {
                    mConfig.mDuckingPolicy = behavior;
                }
                return status;
            } catch (RemoteException e) {
                Log.e(TAG, "Dead object in setFocusPropertiesForPolicy for behavior", e);
                return AudioManager.ERROR;
            }
        }
    }


Number 353:
API Relative Path:
src.android.media.AudioRecord.java-getTimestamp(AudioTimestamp-int)
Corresponding Source:
/**
     * Poll for an {@link AudioTimestamp} on demand.
     * <p>
     * The AudioTimestamp reflects the frame delivery information at
     * the earliest point available in the capture pipeline.
     * <p>
     * Calling {@link #startRecording()} following a {@link #stop()} will reset
     * the frame count to 0.
     *
     * @param outTimestamp a caller provided non-null AudioTimestamp instance,
     *        which is updated with the AudioRecord frame delivery information upon success.
     * @param timebase one of
     *        {@link AudioTimestamp#TIMEBASE_BOOTTIME AudioTimestamp.TIMEBASE_BOOTTIME} or
     *        {@link AudioTimestamp#TIMEBASE_MONOTONIC AudioTimestamp.TIMEBASE_MONOTONIC},
     *        used to select the clock for the AudioTimestamp time.
     * @return {@link #SUCCESS} if a timestamp is available,
     *         or {@link #ERROR_INVALID_OPERATION} if a timestamp not available.
     */
     public int getTimestamp(@NonNull AudioTimestamp outTimestamp,
             @AudioTimestamp.Timebase int timebase)
     {
         if (outTimestamp == null ||
                 (timebase != AudioTimestamp.TIMEBASE_BOOTTIME
                 && timebase != AudioTimestamp.TIMEBASE_MONOTONIC)) {
             throw new IllegalArgumentException();
         }
         return native_get_timestamp(outTimestamp, timebase);
     }


Number 354:
API Relative Path:
src.android.media.AudioTrack.java-AudioTrack(AudioAttributes-AudioFormat-int-int-int)
Corresponding Source:
/**
     * Class constructor with {@link AudioAttributes} and {@link AudioFormat}.
     * @param attributes a non-null {@link AudioAttributes} instance.
     * @param format a non-null {@link AudioFormat} instance describing the format of the data
     *     that will be played through this AudioTrack. See {@link AudioFormat.Builder} for
     *     configuring the audio format parameters such as encoding, channel mask and sample rate.
     * @param bufferSizeInBytes the total size (in bytes) of the internal buffer where audio data is
     *   read from for playback. This should be a nonzero multiple of the frame size in bytes.
     *   <p> If the track's creation mode is {@link #MODE_STATIC},
     *   this is the maximum length sample, or audio clip, that can be played by this instance.
     *   <p> If the track's creation mode is {@link #MODE_STREAM},
     *   this should be the desired buffer size
     *   for the <code>AudioTrack</code> to satisfy the application's
     *   latency requirements.
     *   If <code>bufferSizeInBytes</code> is less than the
     *   minimum buffer size for the output sink, it is increased to the minimum
     *   buffer size.
     *   The method {@link #getBufferSizeInFrames()} returns the
     *   actual size in frames of the buffer created, which
     *   determines the minimum frequency to write
     *   to the streaming <code>AudioTrack</code> to avoid underrun.
     *   See {@link #getMinBufferSize(int, int, int)} to determine the estimated minimum buffer size
     *   for an AudioTrack instance in streaming mode.
     * @param mode streaming or static buffer. See {@link #MODE_STATIC} and {@link #MODE_STREAM}.
     * @param sessionId ID of audio session the AudioTrack must be attached to, or
     *   {@link AudioManager#AUDIO_SESSION_ID_GENERATE} if the session isn't known at construction
     *   time. See also {@link AudioManager#generateAudioSessionId()} to obtain a session ID before
     *   construction.
     * @throws IllegalArgumentException
     */
    public AudioTrack(AudioAttributes attributes, AudioFormat format, int bufferSizeInBytes,
            int mode, int sessionId)
                    throws IllegalArgumentException {
        super(attributes);
        // mState already == STATE_UNINITIALIZED

        if (format == null) {
            throw new IllegalArgumentException("Illegal null AudioFormat");
        }

        // remember which looper is associated with the AudioTrack instantiation
        Looper looper;
        if ((looper = Looper.myLooper()) == null) {
            looper = Looper.getMainLooper();
        }

        int rate = format.getSampleRate();
        if (rate == AudioFormat.SAMPLE_RATE_UNSPECIFIED) {
            rate = 0;
        }

        int channelIndexMask = 0;
        if ((format.getPropertySetMask()
                & AudioFormat.AUDIO_FORMAT_HAS_PROPERTY_CHANNEL_INDEX_MASK) != 0) {
            channelIndexMask = format.getChannelIndexMask();
        }
        int channelMask = 0;
        if ((format.getPropertySetMask()
                & AudioFormat.AUDIO_FORMAT_HAS_PROPERTY_CHANNEL_MASK) != 0) {
            channelMask = format.getChannelMask();
        } else if (channelIndexMask == 0) { // if no masks at all, use stereo
            channelMask = AudioFormat.CHANNEL_OUT_FRONT_LEFT
                    | AudioFormat.CHANNEL_OUT_FRONT_RIGHT;
        }
        int encoding = AudioFormat.ENCODING_DEFAULT;
        if ((format.getPropertySetMask() & AudioFormat.AUDIO_FORMAT_HAS_PROPERTY_ENCODING) != 0) {
            encoding = format.getEncoding();
        }
        audioParamCheck(rate, channelMask, channelIndexMask, encoding, mode);
        mStreamType = AudioSystem.STREAM_DEFAULT;

        audioBuffSizeCheck(bufferSizeInBytes);

        mInitializationLooper = looper;

        if (sessionId < 0) {
            throw new IllegalArgumentException("Invalid audio session ID: "+sessionId);
        }

        int[] sampleRate = new int[] {mSampleRate};
        int[] session = new int[1];
        session[0] = sessionId;
        // native initialization
        int initResult = native_setup(new WeakReference<AudioTrack>(this), mAttributes,
                sampleRate, mChannelMask, mChannelIndexMask, mAudioFormat,
                mNativeBufferSizeInBytes, mDataLoadMode, session, 0 /*nativeTrackInJavaObj*/);
        if (initResult != SUCCESS) {
            loge("Error code "+initResult+" when initializing AudioTrack.");
            return; // with mState == STATE_UNINITIALIZED
        }

        mSampleRate = sampleRate[0];
        mSessionId = session[0];

        if (mDataLoadMode == MODE_STATIC) {
            mState = STATE_NO_STATIC_DATA;
        } else {
            mState = STATE_INITIALIZED;
        }
    }


Number 355:
API Relative Path:
src.android.media.AudioTrack.java-setPlaybackParams(PlaybackParams)
Corresponding Source:
/**
     * Sets the playback parameters.
     * This method returns failure if it cannot apply the playback parameters.
     * One possible cause is that the parameters for speed or pitch are out of range.
     * Another possible cause is that the <code>AudioTrack</code> is streaming
     * (see {@link #MODE_STREAM}) and the
     * buffer size is too small. For speeds greater than 1.0f, the <code>AudioTrack</code> buffer
     * on configuration must be larger than the speed multiplied by the minimum size
     * {@link #getMinBufferSize(int, int, int)}) to allow proper playback.
     * @param params see {@link PlaybackParams}. In particular,
     * speed, pitch, and audio mode should be set.
     * @throws IllegalArgumentException if the parameters are invalid or not accepted.
     * @throws IllegalStateException if track is not initialized.
     */
    public void setPlaybackParams(@NonNull PlaybackParams params) {
        if (params == null) {
            throw new IllegalArgumentException("params is null");
        }
        native_set_playback_params(params);
    }


Number 356:
API Relative Path:
src.android.media.browse.MediaBrowser.java-getItem(String-ItemCallback)
Corresponding Source:
/**
     * Retrieves a specific {@link MediaItem} from the connected service. Not
     * all services may support this, so falling back to subscribing to the
     * parent's id should be used when unavailable.
     *
     * @param mediaId The id of the item to retrieve.
     * @param cb The callback to receive the result on.
     */
    public void getItem(final @NonNull String mediaId, @NonNull final ItemCallback cb) {
        if (TextUtils.isEmpty(mediaId)) {
            throw new IllegalArgumentException("mediaId is empty.");
        }
        if (cb == null) {
            throw new IllegalArgumentException("cb is null.");
        }
        if (mState != CONNECT_STATE_CONNECTED) {
            Log.i(TAG, "Not connected, unable to retrieve the MediaItem.");
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    cb.onError(mediaId);
                }
            });
            return;
        }
        ResultReceiver receiver = new ResultReceiver(mHandler) {
            @Override
            protected void onReceiveResult(int resultCode, Bundle resultData) {
                if (resultCode != 0 || resultData == null
                        || !resultData.containsKey(MediaBrowserService.KEY_MEDIA_ITEM)) {
                    cb.onError(mediaId);
                    return;
                }
                Parcelable item = resultData.getParcelable(MediaBrowserService.KEY_MEDIA_ITEM);
                if (!(item instanceof MediaItem)) {
                    cb.onError(mediaId);
                    return;
                }
                cb.onItemLoaded((MediaItem)item);
            }
        };
        try {
            mServiceBinder.getMediaItem(mediaId, receiver, mServiceCallbacks);
        } catch (RemoteException e) {
            Log.i(TAG, "Remote error getting media item.");
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    cb.onError(mediaId);
                }
            });
        }
    }


Number 357:
API Relative Path:
src.android.media.browse.MediaBrowser.java-MediaBrowser(Context-ComponentName-ConnectionCallback-Bundle)
Corresponding Source:
/**
     * Creates a media browser for the specified media browse service.
     *
     * @param context The context.
     * @param serviceComponent The component name of the media browse service.
     * @param callback The connection callback.
     * @param rootHints An optional bundle of service-specific arguments to send
     * to the media browse service when connecting and retrieving the root id
     * for browsing, or null if none. The contents of this bundle may affect
     * the information returned when browsing.
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_RECENT
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_OFFLINE
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_SUGGESTED
     */
    public MediaBrowser(Context context, ComponentName serviceComponent,
            ConnectionCallback callback, Bundle rootHints) {
        if (context == null) {
            throw new IllegalArgumentException("context must not be null");
        }
        if (serviceComponent == null) {
            throw new IllegalArgumentException("service component must not be null");
        }
        if (callback == null) {
            throw new IllegalArgumentException("connection callback must not be null");
        }
        mContext = context;
        mServiceComponent = serviceComponent;
        mCallback = callback;
        mRootHints = rootHints == null ? null : new Bundle(rootHints);
    }


Number 358:
API Relative Path:
src.android.media.browse.MediaBrowser.java-MediaBrowser(Context-ComponentName-ConnectionCallback-Bundle)
Corresponding Source:
/**
     * Creates a media browser for the specified media browse service.
     *
     * @param context The context.
     * @param serviceComponent The component name of the media browse service.
     * @param callback The connection callback.
     * @param rootHints An optional bundle of service-specific arguments to send
     * to the media browse service when connecting and retrieving the root id
     * for browsing, or null if none. The contents of this bundle may affect
     * the information returned when browsing.
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_RECENT
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_OFFLINE
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_SUGGESTED
     */
    public MediaBrowser(Context context, ComponentName serviceComponent,
            ConnectionCallback callback, Bundle rootHints) {
        if (context == null) {
            throw new IllegalArgumentException("context must not be null");
        }
        if (serviceComponent == null) {
            throw new IllegalArgumentException("service component must not be null");
        }
        if (callback == null) {
            throw new IllegalArgumentException("connection callback must not be null");
        }
        mContext = context;
        mServiceComponent = serviceComponent;
        mCallback = callback;
        mRootHints = rootHints == null ? null : new Bundle(rootHints);
    }


Number 359:
API Relative Path:
src.android.media.browse.MediaBrowser.java-MediaBrowser(Context-ComponentName-ConnectionCallback-Bundle)
Corresponding Source:
/**
     * Creates a media browser for the specified media browse service.
     *
     * @param context The context.
     * @param serviceComponent The component name of the media browse service.
     * @param callback The connection callback.
     * @param rootHints An optional bundle of service-specific arguments to send
     * to the media browse service when connecting and retrieving the root id
     * for browsing, or null if none. The contents of this bundle may affect
     * the information returned when browsing.
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_RECENT
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_OFFLINE
     * @see android.service.media.MediaBrowserService.BrowserRoot#EXTRA_SUGGESTED
     */
    public MediaBrowser(Context context, ComponentName serviceComponent,
            ConnectionCallback callback, Bundle rootHints) {
        if (context == null) {
            throw new IllegalArgumentException("context must not be null");
        }
        if (serviceComponent == null) {
            throw new IllegalArgumentException("service component must not be null");
        }
        if (callback == null) {
            throw new IllegalArgumentException("connection callback must not be null");
        }
        mContext = context;
        mServiceComponent = serviceComponent;
        mCallback = callback;
        mRootHints = rootHints == null ? null : new Bundle(rootHints);
    }


Number 360:
API Relative Path:
src.android.media.browse.MediaBrowser.java-subscribe(String-Bundle-SubscriptionCallback)
Corresponding Source:
/**
     * Queries with service-specific arguments for information about the media items
     * that are contained within the specified id and subscribes to receive updates
     * when they change.
     * <p>
     * The list of subscriptions is maintained even when not connected and is
     * restored after the reconnection. It is ok to subscribe while not connected
     * but the results will not be returned until the connection completes.
     * </p>
     * <p>
     * If the id is already subscribed with a different callback then the new
     * callback will replace the previous one and the child data will be
     * reloaded.
     * </p>
     *
     * @param parentId The id of the parent media item whose list of children
     *            will be subscribed.
     * @param options A bundle of service-specific arguments to send to the media
     *            browse service. The contents of this bundle may affect the
     *            information returned when browsing.
     * @param callback The callback to receive the list of children.
     */
    public void subscribe(@NonNull String parentId, @NonNull Bundle options,
            @NonNull SubscriptionCallback callback) {
        if (options == null) {
            throw new IllegalArgumentException("options are null");
        }
        subscribeInternal(parentId, new Bundle(options), callback);
    }


Number 361:
API Relative Path:
src.android.media.browse.MediaBrowser.java-unsubscribe(String-SubscriptionCallback)
Corresponding Source:
/**
     * Unsubscribes for changes to the children of the specified media id through a callback.
     * <p>
     * The query callback will no longer be invoked for results associated with
     * this id once this method returns.
     * </p>
     *
     * @param parentId The id of the parent media item whose list of children
     *            will be unsubscribed.
     * @param callback A callback sent to the media browse service to subscribe.
     */
    public void unsubscribe(@NonNull String parentId, @NonNull SubscriptionCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback is null");
        }
        unsubscribeInternal(parentId, callback);
    }


Number 362:
API Relative Path:
src.android.media.CamcorderProfile.java-get(int-int)
Corresponding Source:
/**
     * Returns the camcorder profile for the given camera at the given
     * quality level.
     *
     * Quality levels QUALITY_LOW, QUALITY_HIGH are guaranteed to be supported, while
     * other levels may or may not be supported. The supported levels can be checked using
     * {@link #hasProfile(int, int)}.
     * QUALITY_LOW refers to the lowest quality available, while QUALITY_HIGH refers to
     * the highest quality available.
     * QUALITY_LOW/QUALITY_HIGH have to match one of qcif, cif, 480p, 720p, 1080p or 2160p.
     * E.g. if the device supports 480p, 720p, 1080p and 2160p, then low is 480p and high is
     * 2160p.
     *
     * The same is true for time lapse quality levels, i.e. QUALITY_TIME_LAPSE_LOW,
     * QUALITY_TIME_LAPSE_HIGH are guaranteed to be supported and have to match one of
     * qcif, cif, 480p, 720p, 1080p, or 2160p.
     *
     * For high speed quality levels, they may or may not be supported. If a subset of the levels
     * are supported, QUALITY_HIGH_SPEED_LOW and QUALITY_HIGH_SPEED_HIGH are guaranteed to be
     * supported and have to match one of 480p, 720p, or 1080p.
     *
     * A camcorder recording session with higher quality level usually has higher output
     * bit rate, better video and/or audio recording quality, larger video frame
     * resolution and higher audio sampling rate, etc, than those with lower quality
     * level.
     *
     * @param cameraId the id for the camera
     * @param quality the target quality level for the camcorder profile.
     * @see #QUALITY_LOW
     * @see #QUALITY_HIGH
     * @see #QUALITY_QCIF
     * @see #QUALITY_CIF
     * @see #QUALITY_480P
     * @see #QUALITY_720P
     * @see #QUALITY_1080P
     * @see #QUALITY_2160P
     * @see #QUALITY_TIME_LAPSE_LOW
     * @see #QUALITY_TIME_LAPSE_HIGH
     * @see #QUALITY_TIME_LAPSE_QCIF
     * @see #QUALITY_TIME_LAPSE_CIF
     * @see #QUALITY_TIME_LAPSE_480P
     * @see #QUALITY_TIME_LAPSE_720P
     * @see #QUALITY_TIME_LAPSE_1080P
     * @see #QUALITY_TIME_LAPSE_2160P
     * @see #QUALITY_HIGH_SPEED_LOW
     * @see #QUALITY_HIGH_SPEED_HIGH
     * @see #QUALITY_HIGH_SPEED_480P
     * @see #QUALITY_HIGH_SPEED_720P
     * @see #QUALITY_HIGH_SPEED_1080P
     * @see #QUALITY_HIGH_SPEED_2160P
    */
    public static CamcorderProfile get(int cameraId, int quality) {
        if (!((quality >= QUALITY_LIST_START &&
               quality <= QUALITY_LIST_END) ||
              (quality >= QUALITY_TIME_LAPSE_LIST_START &&
               quality <= QUALITY_TIME_LAPSE_LIST_END) ||
               (quality >= QUALITY_HIGH_SPEED_LIST_START &&
               quality <= QUALITY_HIGH_SPEED_LIST_END))) {
            String errMessage = "Unsupported quality level: " + quality;
            throw new IllegalArgumentException(errMessage);
        }
        return native_get_camcorder_profile(cameraId, quality);
    }


Number 363:
API Relative Path:
src.android.media.CameraProfile.java-getJpegEncodingQualityParameter(int-int)
Corresponding Source:
/**
     * Returns a pre-defined still image capture (jpeg) quality level
     * used for the given quality level in the Camera application for
     * the specified camera.
     *
     * @param cameraId The id of the camera
     * @param quality The target quality level
     */
    public static int getJpegEncodingQualityParameter(int cameraId, int quality) {
        if (quality < QUALITY_LOW || quality > QUALITY_HIGH) {
            throw new IllegalArgumentException("Unsupported quality level: " + quality);
        }
        synchronized (sCache) {
            int[] levels = sCache.get(cameraId);
            if (levels == null) {
                levels = getImageEncodingQualityLevels(cameraId);
                sCache.put(cameraId, levels);
            }
            return levels[quality];
        }
    }


Number 364:
API Relative Path:
src.android.media.ExifInterface.java-ExifInterface(FileDescriptor)
Corresponding Source:
/**
     * Reads Exif tags from the specified image file descriptor. Attribute mutation is supported
     * for writable and seekable file descriptors only. This constructor will not rewind the offset
     * of the given file descriptor. Developers should close the file descriptor after use.
     */
    public ExifInterface(FileDescriptor fileDescriptor) throws IOException {
        if (fileDescriptor == null) {
            throw new IllegalArgumentException("fileDescriptor cannot be null");
        }
        mAssetInputStream = null;
        mFilename = null;
        if (isSeekableFD(fileDescriptor)) {
            mSeekableFileDescriptor = fileDescriptor;
            // Keep the original file descriptor in order to save attributes when it's seekable.
            // Otherwise, just close the given file descriptor after reading it because the save
            // feature won't be working.
            try {
                fileDescriptor = Os.dup(fileDescriptor);
            } catch (ErrnoException e) {
                throw e.rethrowAsIOException();
            }
        } else {
            mSeekableFileDescriptor = null;
        }
        mIsInputStream = false;
        FileInputStream in = null;
        try {
            in = new FileInputStream(fileDescriptor);
            loadAttributes(in);
        } finally {
            IoUtils.closeQuietly(in);
        }
    }


Number 365:
API Relative Path:
src.android.media.ExifInterface.java-ExifInterface(InputStream)
Corresponding Source:
/**
     * Reads Exif tags from the specified image input stream. Attribute mutation is not supported
     * for input streams. The given input stream will proceed its current position. Developers
     * should close the input stream after use.
     */
    public ExifInterface(InputStream inputStream) throws IOException {
        if (inputStream == null) {
            throw new IllegalArgumentException("inputStream cannot be null");
        }
        mFilename = null;
        if (inputStream instanceof AssetManager.AssetInputStream) {
            mAssetInputStream = (AssetManager.AssetInputStream) inputStream;
            mSeekableFileDescriptor = null;
        } else if (inputStream instanceof FileInputStream
                && isSeekableFD(((FileInputStream) inputStream).getFD())) {
            mAssetInputStream = null;
            mSeekableFileDescriptor = ((FileInputStream) inputStream).getFD();
        } else {
            mAssetInputStream = null;
            mSeekableFileDescriptor = null;
        }
        mIsInputStream = true;
        loadAttributes(inputStream);
    }


Number 366:
API Relative Path:
src.android.media.ExifInterface.java-ExifInterface(String)
Corresponding Source:
/**
     * Reads Exif tags from the specified image file.
     */
    public ExifInterface(String filename) throws IOException {
        if (filename == null) {
            throw new IllegalArgumentException("filename cannot be null");
        }
        FileInputStream in = null;
        mAssetInputStream = null;
        mFilename = filename;
        mIsInputStream = false;
        try {
            in = new FileInputStream(filename);
            if (isSeekableFD(in.getFD())) {
                mSeekableFileDescriptor = in.getFD();
            } else {
                mSeekableFileDescriptor = null;
            }
            loadAttributes(in);
        } finally {
            IoUtils.closeQuietly(in);
        }
    }


Number 367:
API Relative Path:
src.android.media.FaceDetector.java-findFaces(Bitmap-Face[])
Corresponding Source:
/**
     * Finds all the faces found in a given {@link android.graphics.Bitmap}. 
     * The supplied array is populated with {@link FaceDetector.Face}s for each
     * face found. The bitmap must be in 565 format (for now).
     * 
     * @param bitmap the {@link android.graphics.Bitmap} graphic to be analyzed
     * @param faces  an array in which to place all found 
     *               {@link FaceDetector.Face}s. The array must be sized equal
     *               to the <var>maxFaces</var> value set at initialization
     * @return the number of faces found
     * @throws IllegalArgumentException if the Bitmap dimensions don't match
     *               the dimensions defined at initialization or the given array 
     *               is not sized equal to the <var>maxFaces</var> value defined
     *               at initialization
     */
    public int findFaces(Bitmap bitmap, Face[] faces)
    {
        if (!sInitialized) {
            return 0;
        }
        if (bitmap.getWidth() != mWidth || bitmap.getHeight() != mHeight) {
            throw new IllegalArgumentException(
                    "bitmap size doesn't match initialization");
        }
        if (faces.length < mMaxFaces) {
            throw new IllegalArgumentException(
                    "faces[] smaller than maxFaces");
        }
        
        int numFaces = fft_detect(bitmap);
        if (numFaces >= mMaxFaces)
            numFaces = mMaxFaces;
        for (int i=0 ; i<numFaces ; i++) {
            if (faces[i] == null)
                faces[i] = new Face();
            fft_get_face(faces[i], i);
        }
        return numFaces;
    }


Number 368:
API Relative Path:
src.android.media.ImageReader.java-detachImage(Image)
Corresponding Source:
private synchronized native int nativeDetachImage(Image i);


Number 369:
API Relative Path:
src.android.media.ImageReader.java-ImageReader(int-int-int-int)
Corresponding Source:
/**
     * @hide
     */
    protected ImageReader(int width, int height, int format, int maxImages) {
        mWidth = width;
        mHeight = height;
        mFormat = format;
        mMaxImages = maxImages;

        if (width < 1 || height < 1) {
            throw new IllegalArgumentException(
                "The image dimensions must be positive");
        }
        if (mMaxImages < 1) {
            throw new IllegalArgumentException(
                "Maximum outstanding image count must be at least 1");
        }

        if (format == ImageFormat.NV21) {
            throw new IllegalArgumentException(
                    "NV21 format is not supported");
        }

        mNumPlanes = ImageUtils.getNumPlanesForFormat(mFormat);

        nativeInit(new WeakReference<ImageReader>(this), width, height, format, maxImages);

        mSurface = nativeGetSurface();

        mIsReaderValid = true;
        // Estimate the native buffer allocation size and register it so it gets accounted for
        // during GC. Note that this doesn't include the buffers required by the buffer queue
        // itself and the buffers requested by the producer.
        // Only include memory for 1 buffer, since actually accounting for the memory used is
        // complex, and 1 buffer is enough for the VM to treat the ImageReader as being of some
        // size.
        mEstimatedNativeAllocBytes = ImageUtils.getEstimatedNativeAllocBytes(
                width, height, format, /*buffer count*/ 1);
        VMRuntime.getRuntime().registerNativeAllocation(mEstimatedNativeAllocBytes);
    }


Number 370:
API Relative Path:
src.android.media.ImageReader.java-ImageReader(int-int-int-int)
Corresponding Source:
/**
     * @hide
     */
    protected ImageReader(int width, int height, int format, int maxImages) {
        mWidth = width;
        mHeight = height;
        mFormat = format;
        mMaxImages = maxImages;

        if (width < 1 || height < 1) {
            throw new IllegalArgumentException(
                "The image dimensions must be positive");
        }
        if (mMaxImages < 1) {
            throw new IllegalArgumentException(
                "Maximum outstanding image count must be at least 1");
        }

        if (format == ImageFormat.NV21) {
            throw new IllegalArgumentException(
                    "NV21 format is not supported");
        }

        mNumPlanes = ImageUtils.getNumPlanesForFormat(mFormat);

        nativeInit(new WeakReference<ImageReader>(this), width, height, format, maxImages);

        mSurface = nativeGetSurface();

        mIsReaderValid = true;
        // Estimate the native buffer allocation size and register it so it gets accounted for
        // during GC. Note that this doesn't include the buffers required by the buffer queue
        // itself and the buffers requested by the producer.
        // Only include memory for 1 buffer, since actually accounting for the memory used is
        // complex, and 1 buffer is enough for the VM to treat the ImageReader as being of some
        // size.
        mEstimatedNativeAllocBytes = ImageUtils.getEstimatedNativeAllocBytes(
                width, height, format, /*buffer count*/ 1);
        VMRuntime.getRuntime().registerNativeAllocation(mEstimatedNativeAllocBytes);
    }


Number 371:
API Relative Path:
src.android.media.ImageReader.java-setOnImageAvailableListener(OnImageAvailableListener-Handler)
Corresponding Source:
/**
     * Register a listener to be invoked when a new image becomes available
     * from the ImageReader.
     *
     * @param listener
     *            The listener that will be run.
     * @param handler
     *            The handler on which the listener should be invoked, or null
     *            if the listener should be invoked on the calling thread's looper.
     * @throws IllegalArgumentException
     *            If no handler specified and the calling thread has no looper.
     */
    public void setOnImageAvailableListener(OnImageAvailableListener listener, Handler handler) {
        synchronized (mListenerLock) {
            if (listener != null) {
                Looper looper = handler != null ? handler.getLooper() : Looper.myLooper();
                if (looper == null) {
                    throw new IllegalArgumentException(
                            "handler is null but the current thread is not a looper");
                }
                if (mListenerHandler == null || mListenerHandler.getLooper() != looper) {
                    mListenerHandler = new ListenerHandler(looper);
                }
                mListener = listener;
            } else {
                mListener = null;
                mListenerHandler = null;
            }
        }
    }


Number 372:
API Relative Path:
src.android.media.ImageUtils.java-imageCopy(Image-Image)
Corresponding Source:
/**
     * <p>
     * Copy source image data to destination Image.
     * </p>
     * <p>
     * Only support the copy between two non-{@link ImageFormat#PRIVATE PRIVATE} format
     * images with same properties (format, size, etc.). The data from the
     * source image will be copied to the byteBuffers from the destination Image
     * starting from position zero, and the destination image will be rewound to
     * zero after copy is done.
     * </p>
     *
     * @param src The source image to be copied from.
     * @param dst The destination image to be copied to.
     * @throws IllegalArgumentException If the source and destination images
     *             have different format, or one of the images is not copyable.
     */
    public static void imageCopy(Image src, Image dst) {
        if (src == null || dst == null) {
            throw new IllegalArgumentException("Images should be non-null");
        }
        if (src.getFormat() != dst.getFormat()) {
            throw new IllegalArgumentException("Src and dst images should have the same format");
        }
        if (src.getFormat() == ImageFormat.PRIVATE ||
                dst.getFormat() == ImageFormat.PRIVATE) {
            throw new IllegalArgumentException("PRIVATE format images are not copyable");
        }
        if (src.getFormat() == ImageFormat.RAW_PRIVATE) {
            throw new IllegalArgumentException(
                    "Copy of RAW_OPAQUE format has not been implemented");
        }
        if (!(dst.getOwner() instanceof ImageWriter)) {
            throw new IllegalArgumentException("Destination image is not from ImageWriter. Only"
                    + " the images from ImageWriter are writable");
        }
        Size srcSize = new Size(src.getWidth(), src.getHeight());
        Size dstSize = new Size(dst.getWidth(), dst.getHeight());
        if (!srcSize.equals(dstSize)) {
            throw new IllegalArgumentException("source image size " + srcSize + " is different"
                    + " with " + "destination image size " + dstSize);
        }

        Plane[] srcPlanes = src.getPlanes();
        Plane[] dstPlanes = dst.getPlanes();
        ByteBuffer srcBuffer = null;
        ByteBuffer dstBuffer = null;
        for (int i = 0; i < srcPlanes.length; i++) {
            int srcRowStride = srcPlanes[i].getRowStride();
            int dstRowStride = dstPlanes[i].getRowStride();
            srcBuffer = srcPlanes[i].getBuffer();
            dstBuffer = dstPlanes[i].getBuffer();
            if (!(srcBuffer.isDirect() && dstBuffer.isDirect())) {
                throw new IllegalArgumentException("Source and destination ByteBuffers must be"
                        + " direct byteBuffer!");
            }
            if (srcPlanes[i].getPixelStride() != dstPlanes[i].getPixelStride()) {
                throw new IllegalArgumentException("Source plane image pixel stride " +
                        srcPlanes[i].getPixelStride() +
                        " must be same as destination image pixel stride " +
                        dstPlanes[i].getPixelStride());
            }

            int srcPos = srcBuffer.position();
            srcBuffer.rewind();
            dstBuffer.rewind();
            if (srcRowStride == dstRowStride) {
                // Fast path, just copy the content if the byteBuffer all together.
                dstBuffer.put(srcBuffer);
            } else {
                // Source and destination images may have different alignment requirements,
                // therefore may have different strides. Copy row by row for such case.
                int srcOffset = srcBuffer.position();
                int dstOffset = dstBuffer.position();
                Size effectivePlaneSize = getEffectivePlaneSizeForImage(src, i);
                int srcByteCount = effectivePlaneSize.getWidth() * srcPlanes[i].getPixelStride();
                for (int row = 0; row < effectivePlaneSize.getHeight(); row++) {
                    if (row == effectivePlaneSize.getHeight() - 1) {
                        // Special case for NV21 backed YUV420_888: need handle the last row
                        // carefully to avoid memory corruption. Check if we have enough bytes to
                        // copy.
                        int remainingBytes = srcBuffer.remaining() - srcOffset;
                        if (srcByteCount > remainingBytes) {
                            srcByteCount = remainingBytes;
                        }
                    }
                    directByteBufferCopy(srcBuffer, srcOffset, dstBuffer, dstOffset, srcByteCount);
                    srcOffset += srcRowStride;
                    dstOffset += dstRowStride;
                }
            }

            srcBuffer.position(srcPos);
            dstBuffer.rewind();
        }
    }


Number 373:
API Relative Path:
src.android.media.ImageWriter.java-ImageWriter(Surface-int)
Corresponding Source:
/**
     * @hide
     */
    protected ImageWriter(Surface surface, int maxImages) {
        if (surface == null || maxImages < 1) {
            throw new IllegalArgumentException("Illegal input argument: surface " + surface
                    + ", maxImages: " + maxImages);
        }

        mMaxImages = maxImages;
        // Note that the underlying BufferQueue is working in synchronous mode
        // to avoid dropping any buffers.
        mNativeContext = nativeInit(new WeakReference<ImageWriter>(this), surface, maxImages);

        // Estimate the native buffer allocation size and register it so it gets accounted for
        // during GC. Note that this doesn't include the buffers required by the buffer queue
        // itself and the buffers requested by the producer.
        // Only include memory for 1 buffer, since actually accounting for the memory used is
        // complex, and 1 buffer is enough for the VM to treat the ImageWriter as being of some
        // size.
        Size surfSize = SurfaceUtils.getSurfaceSize(surface);
        int format = SurfaceUtils.getSurfaceFormat(surface);
        mEstimatedNativeAllocBytes =
                ImageUtils.getEstimatedNativeAllocBytes(surfSize.getWidth(),surfSize.getHeight(),
                        format, /*buffer count*/ 1);
        VMRuntime.getRuntime().registerNativeAllocation(mEstimatedNativeAllocBytes);
    }


Number 374:
API Relative Path:
src.android.media.ImageWriter.java-queueInputImage(Image)
Corresponding Source:
/**
     * <p>
     * Attach and queue input Image to this ImageWriter.
     * </p>
     * <p>
     * When the format of an Image is {@link ImageFormat#PRIVATE PRIVATE}, or
     * the source Image is so large that copying its data is too expensive, this
     * method can be used to migrate the source Image into ImageWriter without a
     * data copy, and then queue it to this ImageWriter. The source Image must
     * be detached from its previous owner already, or this call will throw an
     * {@link IllegalStateException}.
     * </p>
     * <p>
     * After this call, the ImageWriter takes ownership of this Image. This
     * ownership will automatically be removed from this writer after the
     * consumer releases this Image, that is, after
     * {@link OnImageReleasedListener#onImageReleased}. The caller is responsible for
     * closing this Image through {@link Image#close()} to free up the resources
     * held by this Image.
     * </p>
     *
     * @param image The source Image to be attached and queued into this
     *            ImageWriter for downstream consumer to use.
     * @throws IllegalStateException if the Image is not detached from its
     *             previous owner, or the Image is already attached to this
     *             ImageWriter, or the source Image is invalid.
     */
    private void attachAndQueueInputImage(Image image) {
        if (image == null) {
            throw new IllegalArgumentException("image shouldn't be null");
        }
        if (isImageOwnedByMe(image)) {
            throw new IllegalArgumentException(
                    "Can not attach an image that is owned ImageWriter already");
        }
        /**
         * Throw ISE if the image is not attachable, which means that it is
         * either owned by other entity now, or completely non-attachable (some
         * stand-alone images are not backed by native gralloc buffer, thus not
         * attachable).
         */
        if (!image.isAttachable()) {
            throw new IllegalStateException("Image was not detached from last owner, or image "
                    + " is not detachable");
        }

        // TODO: what if attach failed, throw RTE or detach a slot then attach?
        // need do some cleanup to make sure no orphaned
        // buffer caused leak.
        Rect crop = image.getCropRect();
        nativeAttachAndQueueImage(mNativeContext, image.getNativeContext(), image.getFormat(),
                image.getTimestamp(), crop.left, crop.top, crop.right, crop.bottom);
    }


Number 375:
API Relative Path:
src.android.media.ImageWriter.java-queueInputImage(Image)
Corresponding Source:
/**
     * <p>
     * Attach and queue input Image to this ImageWriter.
     * </p>
     * <p>
     * When the format of an Image is {@link ImageFormat#PRIVATE PRIVATE}, or
     * the source Image is so large that copying its data is too expensive, this
     * method can be used to migrate the source Image into ImageWriter without a
     * data copy, and then queue it to this ImageWriter. The source Image must
     * be detached from its previous owner already, or this call will throw an
     * {@link IllegalStateException}.
     * </p>
     * <p>
     * After this call, the ImageWriter takes ownership of this Image. This
     * ownership will automatically be removed from this writer after the
     * consumer releases this Image, that is, after
     * {@link OnImageReleasedListener#onImageReleased}. The caller is responsible for
     * closing this Image through {@link Image#close()} to free up the resources
     * held by this Image.
     * </p>
     *
     * @param image The source Image to be attached and queued into this
     *            ImageWriter for downstream consumer to use.
     * @throws IllegalStateException if the Image is not detached from its
     *             previous owner, or the Image is already attached to this
     *             ImageWriter, or the source Image is invalid.
     */
    private void attachAndQueueInputImage(Image image) {
        if (image == null) {
            throw new IllegalArgumentException("image shouldn't be null");
        }
        if (isImageOwnedByMe(image)) {
            throw new IllegalArgumentException(
                    "Can not attach an image that is owned ImageWriter already");
        }
        /**
         * Throw ISE if the image is not attachable, which means that it is
         * either owned by other entity now, or completely non-attachable (some
         * stand-alone images are not backed by native gralloc buffer, thus not
         * attachable).
         */
        if (!image.isAttachable()) {
            throw new IllegalStateException("Image was not detached from last owner, or image "
                    + " is not detachable");
        }

        // TODO: what if attach failed, throw RTE or detach a slot then attach?
        // need do some cleanup to make sure no orphaned
        // buffer caused leak.
        Rect crop = image.getCropRect();
        nativeAttachAndQueueImage(mNativeContext, image.getNativeContext(), image.getFormat(),
                image.getTimestamp(), crop.left, crop.top, crop.right, crop.bottom);
    }


Number 376:
API Relative Path:
src.android.media.ImageWriter.java-setOnImageReleasedListener(OnImageReleasedListener-Handler)
Corresponding Source:
/**
     * Register a listener to be invoked when an input Image is returned to the
     * ImageWriter.
     *
     * @param listener The listener that will be run.
     * @param handler The handler on which the listener should be invoked, or
     *            null if the listener should be invoked on the calling thread's
     *            looper.
     * @throws IllegalArgumentException If no handler specified and the calling
     *             thread has no looper.
     */
    public void setOnImageReleasedListener(OnImageReleasedListener listener, Handler handler) {
        synchronized (mListenerLock) {
            if (listener != null) {
                Looper looper = handler != null ? handler.getLooper() : Looper.myLooper();
                if (looper == null) {
                    throw new IllegalArgumentException(
                            "handler is null but the current thread is not a looper");
                }
                if (mListenerHandler == null || mListenerHandler.getLooper() != looper) {
                    mListenerHandler = new ListenerHandler(looper);
                }
                mListener = listener;
            } else {
                mListener = null;
                mListenerHandler = null;
            }
        }
    }


Number 377:
API Relative Path:
src.android.media.MediaActionSound.java-load(int)
Corresponding Source:
/**
     * Preload a predefined platform sound to minimize latency when the sound is
     * played later by {@link #play}.
     * @param soundName The type of sound to preload, selected from
     *         SHUTTER_CLICK, FOCUS_COMPLETE, START_VIDEO_RECORDING, or
     *         STOP_VIDEO_RECORDING.
     * @see #play
     * @see #SHUTTER_CLICK
     * @see #FOCUS_COMPLETE
     * @see #START_VIDEO_RECORDING
     * @see #STOP_VIDEO_RECORDING
     */
    public void load(int soundName) {
        if (soundName < 0 || soundName >= SOUND_FILES.length) {
            throw new RuntimeException("Unknown sound requested: " + soundName);
        }
        SoundState sound = mSounds[soundName];
        synchronized (sound) {
            switch (sound.state) {
            case STATE_NOT_LOADED:
                if (loadSound(sound) <= 0) {
                    Log.e(TAG, "load() error loading sound: " + soundName);
                }
                break;
            default:
                Log.e(TAG, "load() called in wrong state: " + sound + " for sound: "+ soundName);
                break;
            }
        }
    }


Number 378:
API Relative Path:
src.android.media.MediaActionSound.java-play(int)
Corresponding Source:
/**
     * <p>Play one of the predefined platform sounds for media actions.</p>
     *
     * <p>Use this method to play a platform-specific sound for various media
     * actions. The sound playback is done asynchronously, with the same
     * behavior and content as the sounds played by
     * {@link android.hardware.Camera#takePicture Camera.takePicture},
     * {@link android.media.MediaRecorder#start MediaRecorder.start}, and
     * {@link android.media.MediaRecorder#stop MediaRecorder.stop}.</p>
     *
     * <p>With the {@link android.hardware.camera2 camera2} API, this method can be used to play
     * standard camera operation sounds with the appropriate system behavior for such sounds.</p>

     * <p>With the older {@link android.hardware.Camera} API, using this method makes it easy to
     * match the default device sounds when recording or capturing data through the preview
     * callbacks, or when implementing custom camera-like features in your application.</p>
     *
     * <p>If the sound has not been loaded by {@link #load} before calling play,
     * play will load the sound at the cost of some additional latency before
     * sound playback begins. </p>
     *
     * @param soundName The type of sound to play, selected from
     *         SHUTTER_CLICK, FOCUS_COMPLETE, START_VIDEO_RECORDING, or
     *         STOP_VIDEO_RECORDING.
     * @see android.hardware.Camera#takePicture
     * @see android.media.MediaRecorder
     * @see #SHUTTER_CLICK
     * @see #FOCUS_COMPLETE
     * @see #START_VIDEO_RECORDING
     * @see #STOP_VIDEO_RECORDING
     */
    public void play(int soundName) {
        if (soundName < 0 || soundName >= SOUND_FILES.length) {
            throw new RuntimeException("Unknown sound requested: " + soundName);
        }
        SoundState sound = mSounds[soundName];
        synchronized (sound) {
            switch (sound.state) {
            case STATE_NOT_LOADED:
                loadSound(sound);
                if (loadSound(sound) <= 0) {
                    Log.e(TAG, "play() error loading sound: " + soundName);
                    break;
                }
                // FALL THROUGH

            case STATE_LOADING:
                sound.state = STATE_LOADING_PLAY_REQUESTED;
                break;
            case STATE_LOADED:
                mSoundPool.play(sound.id, 1.0f, 1.0f, 0, 0, 1.0f);
                break;
            default:
                Log.e(TAG, "play() called in wrong state: " + sound.state + " for sound: "+ soundName);
                break;
            }
        }
    }


Number 379:
API Relative Path:
src.android.media.MediaCodec.java-setInputSurface(Surface)
Corresponding Source:
private native final void native_setInputSurface(@NonNull Surface surface);


Number 380:
API Relative Path:
src.android.media.MediaCodec.java-setParameters(Bundle)
Corresponding Source:
/**
     * Communicate additional parameter changes to the component instance.
     * <b>Note:</b> Some of these parameter changes may silently fail to apply.
     *
     * @param params The bundle of parameters to set.
     * @throws IllegalStateException if in the Released state.
     */
    public final void setParameters(@Nullable Bundle params) {
        if (params == null) {
            return;
        }

        String[] keys = new String[params.size()];
        Object[] values = new Object[params.size()];

        int i = 0;
        for (final String key: params.keySet()) {
            keys[i] = key;
            values[i] = params.get(key);
            ++i;
        }

        setParameters(keys, values);
    }


Number 381:
API Relative Path:
src.android.media.MediaCodecList.java-getCodecInfoAt(int)
Corresponding Source:
/**
     * Return the {@link MediaCodecInfo} object for the codec at
     * the given {@code index} in the regular list.
     *
     * @deprecated Use {@link #getCodecInfos} instead.
     *
     * @see #REGULAR_CODECS
     */
    public static final MediaCodecInfo getCodecInfoAt(int index) {
        initCodecList();
        if (index < 0 || index > sRegularCodecInfos.length) {
            throw new IllegalArgumentException();
        }
        return sRegularCodecInfos[index];
    }


Number 382:
API Relative Path:
src.android.media.MediaMetadataRetriever.java-getFrameAtTime(long-int)
Corresponding Source:
private native Bitmap _getFrameAtTime(long timeUs, int option);


Number 383:
API Relative Path:
src.android.media.MediaMetadataRetriever.java-setDataSource(Context-Uri)
Corresponding Source:
/**
     * Sets the data source as a content Uri. Call this method before 
     * the rest of the methods in this class. This method may be time-consuming.
     * 
     * @param context the Context to use when resolving the Uri
     * @param uri the Content URI of the data you want to play
     * @throws IllegalArgumentException if the Uri is invalid
     * @throws SecurityException if the Uri cannot be used due to lack of
     * permission.
     */
    public void setDataSource(Context context, Uri uri)
        throws IllegalArgumentException, SecurityException {
        if (uri == null) {
            throw new IllegalArgumentException();
        }
        
        String scheme = uri.getScheme();
        if(scheme == null || scheme.equals("file")) {
            setDataSource(uri.getPath());
            return;
        }

        AssetFileDescriptor fd = null;
        try {
            ContentResolver resolver = context.getContentResolver();
            try {
                fd = resolver.openAssetFileDescriptor(uri, "r");
            } catch(FileNotFoundException e) {
                throw new IllegalArgumentException();
            }
            if (fd == null) {
                throw new IllegalArgumentException();
            }
            FileDescriptor descriptor = fd.getFileDescriptor();
            if (!descriptor.valid()) {
                throw new IllegalArgumentException();
            }
            // Note: using getDeclaredLength so that our behavior is the same
            // as previous versions when the content provider is returning
            // a full file.
            if (fd.getDeclaredLength() < 0) {
                setDataSource(descriptor);
            } else {
                setDataSource(descriptor, fd.getStartOffset(), fd.getDeclaredLength());
            }
            return;
        } catch (SecurityException ex) {
        } finally {
            try {
                if (fd != null) {
                    fd.close();
                }
            } catch(IOException ioEx) {
            }
        }
        setDataSource(uri.toString());
    }


Number 384:
API Relative Path:
src.android.media.MediaMetadataRetriever.java-setDataSource(String)
Corresponding Source:
/**
     * Sets the data source (file pathname) to use. Call this
     * method before the rest of the methods in this class. This method may be
     * time-consuming.
     * 
     * @param path The path of the input media file.
     * @throws IllegalArgumentException If the path is invalid.
     */
    public void setDataSource(String path) throws IllegalArgumentException {
        if (path == null) {
            throw new IllegalArgumentException();
        }

        try (FileInputStream is = new FileInputStream(path)) {
            FileDescriptor fd = is.getFD();
            setDataSource(fd, 0, 0x7ffffffffffffffL);
        } catch (FileNotFoundException fileEx) {
            throw new IllegalArgumentException();
        } catch (IOException ioEx) {
            throw new IllegalArgumentException();
        }
    }


Number 385:
API Relative Path:
src.android.media.MediaMuxer.java-addTrack(MediaFormat)
Corresponding Source:
/**
     * Adds a track with the specified format.
     * <p>
     * The following table summarizes support for specific format keys across android releases.
     * Keys marked with '+:' are required.
     *
     * <table style="width: 0%">
     *  <thead>
     *   <tr>
     *    <th rowspan=2>OS Version(s)</th>
     *    <td colspan=3>{@code MediaFormat} keys used for</th>
     *   </tr><tr>
     *    <th>All Tracks</th>
     *    <th>Audio Tracks</th>
     *    <th>Video Tracks</th>
     *   </tr>
     *  </thead>
     *  <tbody>
     *   <tr>
     *    <td>{@link android.os.Build.VERSION_CODES#JELLY_BEAN_MR2}</td>
     *    <td rowspan=7>+: {@link MediaFormat#KEY_MIME}</td>
     *    <td rowspan=3>+: {@link MediaFormat#KEY_SAMPLE_RATE},<br>
     *        +: {@link MediaFormat#KEY_CHANNEL_COUNT},<br>
     *        +: <strong>codec-specific data<sup>AAC</sup></strong></td>
     *    <td rowspan=5>+: {@link MediaFormat#KEY_WIDTH},<br>
     *        +: {@link MediaFormat#KEY_HEIGHT},<br>
     *        no {@code KEY_ROTATION},
     *        use {@link #setOrientationHint setOrientationHint()}<sup>.mp4</sup>,<br>
     *        +: <strong>codec-specific data<sup>AVC, MPEG4</sup></strong></td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#KITKAT}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#KITKAT_WATCH}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#LOLLIPOP}</td>
     *    <td rowspan=4>as above, plus<br>
     *        +: <strong>codec-specific data<sup>Vorbis & .webm</sup></strong></td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#LOLLIPOP_MR1}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#M}</td>
     *    <td>as above, plus<br>
     *        {@link MediaFormat#KEY_BIT_RATE}<sup>AAC</sup></td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#N}</td>
     *    <td>as above, plus<br>
     *        <!-- {link MediaFormat#KEY_MAX_BIT_RATE}<sup>AAC, MPEG4</sup>,<br> -->
     *        {@link MediaFormat#KEY_BIT_RATE}<sup>MPEG4</sup>,<br>
     *        {@link MediaFormat#KEY_HDR_STATIC_INFO}<sup>#, .webm</sup>,<br>
     *        {@link MediaFormat#KEY_COLOR_STANDARD}<sup>#</sup>,<br>
     *        {@link MediaFormat#KEY_COLOR_TRANSFER}<sup>#</sup>,<br>
     *        {@link MediaFormat#KEY_COLOR_RANGE}<sup>#</sup>,<br>
     *        +: <strong>codec-specific data<sup>HEVC</sup></strong>,<br>
     *        codec-specific data<sup>VP9</sup></td>
     *   </tr>
     *   <tr>
     *    <td colspan=4>
     *     <p class=note><strong>Notes:</strong><br>
     *      #: storing into container metadata.<br>
     *      .mp4, .webm&hellip;: for listed containers<br>
     *      MPEG4, AAC&hellip;: for listed codecs
     *    </td>
     *   </tr><tr>
     *    <td colspan=4>
     *     <p class=note>Note that the codec-specific data for the track must be specified using
     *     this method. Furthermore, codec-specific data must not be passed/specified via the
     *     {@link #writeSampleData writeSampleData()} call.
     *    </td>
     *   </tr>
     *  </tbody>
     * </table>
     *
     * <p>
     * The following table summarizes codec support for containers across android releases:
     *
     * <table style="width: 0%">
     *  <thead>
     *   <tr>
     *    <th rowspan=2>OS Version(s)</th>
     *    <td colspan=3>Codec support</th>
     *   </tr><tr>
     *    <th>{@linkplain OutputFormat#MUXER_OUTPUT_MPEG_4 MP4}</th>
     *    <th>{@linkplain OutputFormat#MUXER_OUTPUT_WEBM WEBM}</th>
     *   </tr>
     *  </thead>
     *  <tbody>
     *   <tr>
     *    <td>{@link android.os.Build.VERSION_CODES#JELLY_BEAN_MR2}</td>
     *    <td rowspan=6>{@link MediaFormat#MIMETYPE_AUDIO_AAC AAC},<br>
     *        {@link MediaFormat#MIMETYPE_AUDIO_AMR_NB NB-AMR},<br>
     *        {@link MediaFormat#MIMETYPE_AUDIO_AMR_WB WB-AMR},<br>
     *        {@link MediaFormat#MIMETYPE_VIDEO_H263 H.263},<br>
     *        {@link MediaFormat#MIMETYPE_VIDEO_MPEG4 MPEG-4},<br>
     *        {@link MediaFormat#MIMETYPE_VIDEO_AVC AVC} (H.264)</td>
     *    <td rowspan=3>Not supported</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#KITKAT}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#KITKAT_WATCH}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#LOLLIPOP}</td>
     *    <td rowspan=3>{@link MediaFormat#MIMETYPE_AUDIO_VORBIS Vorbis},<br>
     *        {@link MediaFormat#MIMETYPE_VIDEO_VP8 VP8}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#LOLLIPOP_MR1}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#M}</td>
     *   </tr><tr>
     *    <td>{@link android.os.Build.VERSION_CODES#N}</td>
     *    <td>as above, plus<br>
     *        {@link MediaFormat#MIMETYPE_VIDEO_HEVC HEVC} (H.265)</td>
     *    <td>as above, plus<br>
     *        {@link MediaFormat#MIMETYPE_VIDEO_VP9 VP9}</td>
     *   </tr>
     *  </tbody>
     * </table>
     *
     * @param format The media format for the track.  This must not be an empty
     *               MediaFormat.
     * @return The track index for this newly added track, and it should be used
     * in the {@link #writeSampleData}.
     * @throws IllegalArgumentException if format is invalid.
     * @throws IllegalStateException if muxer is in the wrong state.
     */
    public int addTrack(@NonNull MediaFormat format) {
        if (format == null) {
            throw new IllegalArgumentException("format must not be null.");
        }
        if (mState != MUXER_STATE_INITIALIZED) {
            throw new IllegalStateException("Muxer is not initialized.");
        }
        if (mNativeObject == 0) {
            throw new IllegalStateException("Muxer has been released!");
        }
        int trackIndex = -1;
        // Convert the MediaFormat into key-value pairs and send to the native.
        Map<String, Object> formatMap = format.getMap();

        String[] keys = null;
        Object[] values = null;
        int mapSize = formatMap.size();
        if (mapSize > 0) {
            keys = new String[mapSize];
            values = new Object[mapSize];
            int i = 0;
            for (Map.Entry<String, Object> entry : formatMap.entrySet()) {
                keys[i] = entry.getKey();
                values[i] = entry.getValue();
                ++i;
            }
            trackIndex = nativeAddTrack(mNativeObject, keys, values);
        } else {
            throw new IllegalArgumentException("format must not be empty.");
        }

        // Track index number is expected to incremented as addTrack succeed.
        // However, if format is invalid, it will get a negative trackIndex.
        if (mLastTrackIndex >= trackIndex) {
            throw new IllegalArgumentException("Invalid format.");
        }
        mLastTrackIndex = trackIndex;
        return trackIndex;
    }


Number 386:
API Relative Path:
src.android.media.MediaMuxer.java-MediaMuxer(String-int)
Corresponding Source:
/**
     * Constructor.
     * Creates a media muxer that writes to the specified path.
     * @param path The path of the output media file.
     * @param format The format of the output media file.
     * @see android.media.MediaMuxer.OutputFormat
     * @throws IllegalArgumentException if path is invalid or format is not supported.
     * @throws IOException if failed to open the file for write.
     */
    public MediaMuxer(@NonNull String path, @Format int format) throws IOException {
        if (path == null) {
            throw new IllegalArgumentException("path must not be null");
        }
        if (format != OutputFormat.MUXER_OUTPUT_MPEG_4 &&
                format != OutputFormat.MUXER_OUTPUT_WEBM) {
            throw new IllegalArgumentException("format is invalid");
        }
        // Use RandomAccessFile so we can open the file with RW access;
        // RW access allows the native writer to memory map the output file.
        RandomAccessFile file = null;
        try {
            file = new RandomAccessFile(path, "rws");
            FileDescriptor fd = file.getFD();
            mNativeObject = nativeSetup(fd, format);
            mState = MUXER_STATE_INITIALIZED;
            mCloseGuard.open("release");
        } finally {
            if (file != null) {
                file.close();
            }
        }
    }


Number 387:
API Relative Path:
src.android.media.MediaMuxer.java-MediaMuxer(String-int)
Corresponding Source:
/**
     * Constructor.
     * Creates a media muxer that writes to the specified path.
     * @param path The path of the output media file.
     * @param format The format of the output media file.
     * @see android.media.MediaMuxer.OutputFormat
     * @throws IllegalArgumentException if path is invalid or format is not supported.
     * @throws IOException if failed to open the file for write.
     */
    public MediaMuxer(@NonNull String path, @Format int format) throws IOException {
        if (path == null) {
            throw new IllegalArgumentException("path must not be null");
        }
        if (format != OutputFormat.MUXER_OUTPUT_MPEG_4 &&
                format != OutputFormat.MUXER_OUTPUT_WEBM) {
            throw new IllegalArgumentException("format is invalid");
        }
        // Use RandomAccessFile so we can open the file with RW access;
        // RW access allows the native writer to memory map the output file.
        RandomAccessFile file = null;
        try {
            file = new RandomAccessFile(path, "rws");
            FileDescriptor fd = file.getFD();
            mNativeObject = nativeSetup(fd, format);
            mState = MUXER_STATE_INITIALIZED;
            mCloseGuard.open("release");
        } finally {
            if (file != null) {
                file.close();
            }
        }
    }


Number 388:
API Relative Path:
src.android.media.MediaMuxer.java-setOrientationHint(int)
Corresponding Source:
/**
     * Sets the orientation hint for output video playback.
     * <p>This method should be called before {@link #start}. Calling this
     * method will not rotate the video frame when muxer is generating the file,
     * but add a composition matrix containing the rotation angle in the output
     * video if the output format is
     * {@link OutputFormat#MUXER_OUTPUT_MPEG_4} so that a video player can
     * choose the proper orientation for playback. Note that some video players
     * may choose to ignore the composition matrix in a video during playback.
     * By default, the rotation degree is 0.</p>
     * @param degrees the angle to be rotated clockwise in degrees.
     * The supported angles are 0, 90, 180, and 270 degrees.
     * @throws IllegalArgumentException if degree is not supported.
     * @throws IllegalStateException If this method is called after {@link #start}.
     */
    public void setOrientationHint(int degrees) {
        if (degrees != 0 && degrees != 90  && degrees != 180 && degrees != 270) {
            throw new IllegalArgumentException("Unsupported angle: " + degrees);
        }
        if (mState == MUXER_STATE_INITIALIZED) {
            nativeSetOrientationHint(mNativeObject, degrees);
        } else {
            throw new IllegalStateException("Can't set rotation degrees due" +
                    " to wrong state.");
        }
    }


Number 389:
API Relative Path:
src.android.media.MediaMuxer.java-writeSampleData(int-ByteBuffer-BufferInfo)
Corresponding Source:
/**
     * Writes an encoded sample into the muxer.
     * <p>The application needs to make sure that the samples are written into
     * the right tracks. Also, it needs to make sure the samples for each track
     * are written in chronological order (e.g. in the order they are provided
     * by the encoder.)</p>
     * @param byteBuf The encoded sample.
     * @param trackIndex The track index for this sample.
     * @param bufferInfo The buffer information related to this sample.
     * @throws IllegalArgumentException if trackIndex, byteBuf or bufferInfo is  invalid.
     * @throws IllegalStateException if muxer is in wrong state.
     * MediaMuxer uses the flags provided in {@link MediaCodec.BufferInfo},
     * to signal sync frames.
     */
    public void writeSampleData(int trackIndex, @NonNull ByteBuffer byteBuf,
            @NonNull BufferInfo bufferInfo) {
        if (trackIndex < 0 || trackIndex > mLastTrackIndex) {
            throw new IllegalArgumentException("trackIndex is invalid");
        }

        if (byteBuf == null) {
            throw new IllegalArgumentException("byteBuffer must not be null");
        }

        if (bufferInfo == null) {
            throw new IllegalArgumentException("bufferInfo must not be null");
        }
        if (bufferInfo.size < 0 || bufferInfo.offset < 0
                || (bufferInfo.offset + bufferInfo.size) > byteBuf.capacity()
                || bufferInfo.presentationTimeUs < 0) {
            throw new IllegalArgumentException("bufferInfo must specify a" +
                    " valid buffer offset, size and presentation time");
        }

        if (mNativeObject == 0) {
            throw new IllegalStateException("Muxer has been released!");
        }

        if (mState != MUXER_STATE_STARTED) {
            throw new IllegalStateException("Can't write, muxer is not started");
        }

        nativeWriteSampleData(mNativeObject, trackIndex, byteBuf,
                bufferInfo.offset, bufferInfo.size,
                bufferInfo.presentationTimeUs, bufferInfo.flags);
    }


Number 390:
API Relative Path:
src.android.media.MediaMuxer.java-writeSampleData(int-ByteBuffer-BufferInfo)
Corresponding Source:
/**
     * Writes an encoded sample into the muxer.
     * <p>The application needs to make sure that the samples are written into
     * the right tracks. Also, it needs to make sure the samples for each track
     * are written in chronological order (e.g. in the order they are provided
     * by the encoder.)</p>
     * @param byteBuf The encoded sample.
     * @param trackIndex The track index for this sample.
     * @param bufferInfo The buffer information related to this sample.
     * @throws IllegalArgumentException if trackIndex, byteBuf or bufferInfo is  invalid.
     * @throws IllegalStateException if muxer is in wrong state.
     * MediaMuxer uses the flags provided in {@link MediaCodec.BufferInfo},
     * to signal sync frames.
     */
    public void writeSampleData(int trackIndex, @NonNull ByteBuffer byteBuf,
            @NonNull BufferInfo bufferInfo) {
        if (trackIndex < 0 || trackIndex > mLastTrackIndex) {
            throw new IllegalArgumentException("trackIndex is invalid");
        }

        if (byteBuf == null) {
            throw new IllegalArgumentException("byteBuffer must not be null");
        }

        if (bufferInfo == null) {
            throw new IllegalArgumentException("bufferInfo must not be null");
        }
        if (bufferInfo.size < 0 || bufferInfo.offset < 0
                || (bufferInfo.offset + bufferInfo.size) > byteBuf.capacity()
                || bufferInfo.presentationTimeUs < 0) {
            throw new IllegalArgumentException("bufferInfo must specify a" +
                    " valid buffer offset, size and presentation time");
        }

        if (mNativeObject == 0) {
            throw new IllegalStateException("Muxer has been released!");
        }

        if (mState != MUXER_STATE_STARTED) {
            throw new IllegalStateException("Can't write, muxer is not started");
        }

        nativeWriteSampleData(mNativeObject, trackIndex, byteBuf,
                bufferInfo.offset, bufferInfo.size,
                bufferInfo.presentationTimeUs, bufferInfo.flags);
    }


Number 391:
API Relative Path:
src.android.media.MediaMuxer.java-writeSampleData(int-ByteBuffer-BufferInfo)
Corresponding Source:
/**
     * Writes an encoded sample into the muxer.
     * <p>The application needs to make sure that the samples are written into
     * the right tracks. Also, it needs to make sure the samples for each track
     * are written in chronological order (e.g. in the order they are provided
     * by the encoder.)</p>
     * @param byteBuf The encoded sample.
     * @param trackIndex The track index for this sample.
     * @param bufferInfo The buffer information related to this sample.
     * @throws IllegalArgumentException if trackIndex, byteBuf or bufferInfo is  invalid.
     * @throws IllegalStateException if muxer is in wrong state.
     * MediaMuxer uses the flags provided in {@link MediaCodec.BufferInfo},
     * to signal sync frames.
     */
    public void writeSampleData(int trackIndex, @NonNull ByteBuffer byteBuf,
            @NonNull BufferInfo bufferInfo) {
        if (trackIndex < 0 || trackIndex > mLastTrackIndex) {
            throw new IllegalArgumentException("trackIndex is invalid");
        }

        if (byteBuf == null) {
            throw new IllegalArgumentException("byteBuffer must not be null");
        }

        if (bufferInfo == null) {
            throw new IllegalArgumentException("bufferInfo must not be null");
        }
        if (bufferInfo.size < 0 || bufferInfo.offset < 0
                || (bufferInfo.offset + bufferInfo.size) > byteBuf.capacity()
                || bufferInfo.presentationTimeUs < 0) {
            throw new IllegalArgumentException("bufferInfo must specify a" +
                    " valid buffer offset, size and presentation time");
        }

        if (mNativeObject == 0) {
            throw new IllegalStateException("Muxer has been released!");
        }

        if (mState != MUXER_STATE_STARTED) {
            throw new IllegalStateException("Can't write, muxer is not started");
        }

        nativeWriteSampleData(mNativeObject, trackIndex, byteBuf,
                bufferInfo.offset, bufferInfo.size,
                bufferInfo.presentationTimeUs, bufferInfo.flags);
    }


Number 392:
API Relative Path:
src.android.media.MediaMuxer.java-writeSampleData(int-ByteBuffer-BufferInfo)
Corresponding Source:
/**
     * Writes an encoded sample into the muxer.
     * <p>The application needs to make sure that the samples are written into
     * the right tracks. Also, it needs to make sure the samples for each track
     * are written in chronological order (e.g. in the order they are provided
     * by the encoder.)</p>
     * @param byteBuf The encoded sample.
     * @param trackIndex The track index for this sample.
     * @param bufferInfo The buffer information related to this sample.
     * @throws IllegalArgumentException if trackIndex, byteBuf or bufferInfo is  invalid.
     * @throws IllegalStateException if muxer is in wrong state.
     * MediaMuxer uses the flags provided in {@link MediaCodec.BufferInfo},
     * to signal sync frames.
     */
    public void writeSampleData(int trackIndex, @NonNull ByteBuffer byteBuf,
            @NonNull BufferInfo bufferInfo) {
        if (trackIndex < 0 || trackIndex > mLastTrackIndex) {
            throw new IllegalArgumentException("trackIndex is invalid");
        }

        if (byteBuf == null) {
            throw new IllegalArgumentException("byteBuffer must not be null");
        }

        if (bufferInfo == null) {
            throw new IllegalArgumentException("bufferInfo must not be null");
        }
        if (bufferInfo.size < 0 || bufferInfo.offset < 0
                || (bufferInfo.offset + bufferInfo.size) > byteBuf.capacity()
                || bufferInfo.presentationTimeUs < 0) {
            throw new IllegalArgumentException("bufferInfo must specify a" +
                    " valid buffer offset, size and presentation time");
        }

        if (mNativeObject == 0) {
            throw new IllegalStateException("Muxer has been released!");
        }

        if (mState != MUXER_STATE_STARTED) {
            throw new IllegalStateException("Can't write, muxer is not started");
        }

        nativeWriteSampleData(mNativeObject, trackIndex, byteBuf,
                bufferInfo.offset, bufferInfo.size,
                bufferInfo.presentationTimeUs, bufferInfo.flags);
    }


Number 393:
API Relative Path:
src.android.media.MediaRecorder.java-setAudioChannels(int)
Corresponding Source:
/**
     * Sets the number of audio channels for recording. Call this method before prepare().
     * Prepare() may perform additional checks on the parameter to make sure whether the
     * specified number of audio channels are applicable.
     *
     * @param numChannels the number of audio channels. Usually it is either 1 (mono) or 2
     * (stereo).
     */
    public void setAudioChannels(int numChannels) {
        if (numChannels <= 0) {
            throw new IllegalArgumentException("Number of channels is not positive");
        }
        setParameter("audio-param-number-of-channels=" + numChannels);
    }


Number 394:
API Relative Path:
src.android.media.MediaRecorder.java-setAudioEncodingBitRate(int)
Corresponding Source:
/**
     * Sets the audio encoding bit rate for recording. Call this method before prepare().
     * Prepare() may perform additional checks on the parameter to make sure whether the
     * specified bit rate is applicable, and sometimes the passed bitRate will be clipped
     * internally to ensure the audio recording can proceed smoothly based on the
     * capabilities of the platform.
     *
     * @param bitRate the audio encoding bit rate in bits per second.
     */
    public void setAudioEncodingBitRate(int bitRate) {
        if (bitRate <= 0) {
            throw new IllegalArgumentException("Audio encoding bit rate is not positive");
        }
        setParameter("audio-param-encoding-bitrate=" + bitRate);
    }


Number 395:
API Relative Path:
src.android.media.MediaRecorder.java-setAudioSamplingRate(int)
Corresponding Source:
/**
     * Sets the audio sampling rate for recording. Call this method before prepare().
     * Prepare() may perform additional checks on the parameter to make sure whether
     * the specified audio sampling rate is applicable. The sampling rate really depends
     * on the format for the audio recording, as well as the capabilities of the platform.
     * For instance, the sampling rate supported by AAC audio coding standard ranges
     * from 8 to 96 kHz, the sampling rate supported by AMRNB is 8kHz, and the sampling
     * rate supported by AMRWB is 16kHz. Please consult with the related audio coding
     * standard for the supported audio sampling rate.
     *
     * @param samplingRate the sampling rate for audio in samples per second.
     */
    public void setAudioSamplingRate(int samplingRate) {
        if (samplingRate <= 0) {
            throw new IllegalArgumentException("Audio sampling rate is not positive");
        }
        setParameter("audio-param-sampling-rate=" + samplingRate);
    }


Number 396:
API Relative Path:
src.android.media.MediaRecorder.java-setInputSurface(Surface)
Corresponding Source:
private native final void native_setInputSurface(@NonNull Surface surface);


Number 397:
API Relative Path:
src.android.media.MediaRecorder.java-setOrientationHint(int)
Corresponding Source:
/**
     * Sets the orientation hint for output video playback.
     * This method should be called before prepare(). This method will not
     * trigger the source video frame to rotate during video recording, but to
     * add a composition matrix containing the rotation angle in the output
     * video if the output format is OutputFormat.THREE_GPP or
     * OutputFormat.MPEG_4 so that a video player can choose the proper
     * orientation for playback. Note that some video players may choose
     * to ignore the compostion matrix in a video during playback.
     *
     * @param degrees the angle to be rotated clockwise in degrees.
     * The supported angles are 0, 90, 180, and 270 degrees.
     * @throws IllegalArgumentException if the angle is not supported.
     *
     */
    public void setOrientationHint(int degrees) {
        if (degrees != 0   &&
            degrees != 90  &&
            degrees != 180 &&
            degrees != 270) {
            throw new IllegalArgumentException("Unsupported angle: " + degrees);
        }
        setParameter("video-param-rotation-angle-degrees=" + degrees);
    }


Number 398:
API Relative Path:
src.android.media.MediaRecorder.java-setVideoEncodingBitRate(int)
Corresponding Source:
/**
     * Sets the video encoding bit rate for recording. Call this method before prepare().
     * Prepare() may perform additional checks on the parameter to make sure whether the
     * specified bit rate is applicable, and sometimes the passed bitRate will be
     * clipped internally to ensure the video recording can proceed smoothly based on
     * the capabilities of the platform.
     *
     * @param bitRate the video encoding bit rate in bits per second.
     */
    public void setVideoEncodingBitRate(int bitRate) {
        if (bitRate <= 0) {
            throw new IllegalArgumentException("Video encoding bit rate is not positive");
        }
        setParameter("video-param-encoding-bitrate=" + bitRate);
    }


Number 399:
API Relative Path:
src.android.media.MediaRouter.java-getSelectedRoute(int)
Corresponding Source:
/**
     * Return the currently selected route for any of the given types
     *
     * @param type route types
     * @return the selected route
     */
    public RouteInfo getSelectedRoute(int type) {
        if (sStatic.mSelectedRoute != null &&
                (sStatic.mSelectedRoute.mSupportedTypes & type) != 0) {
            // If the selected route supports any of the types supplied, it's still considered
            // 'selected' for that type.
            return sStatic.mSelectedRoute;
        } else if (type == ROUTE_TYPE_USER) {
            // The caller specifically asked for a user route and the currently selected route
            // doesn't qualify.
            return null;
        }
        // If the above didn't match and we're not specifically asking for a user route,
        // consider the default selected.
        return sStatic.mDefaultAudioVideo;
    }


Number 400:
API Relative Path:
src.android.media.MediaSync.java-setAudioTrack(AudioTrack)
Corresponding Source:
private native final void native_setAudioTrack(@Nullable AudioTrack audioTrack);


Number 401:
API Relative Path:
src.android.media.midi.MidiDevice.java-connectPorts(MidiInputPort-int)
Corresponding Source:
/**
     * Connects the supplied {@link MidiInputPort} to the output port of this device
     * with the specified port number. Once the connection is made, the MidiInput port instance
     * can no longer receive data via its {@link MidiReceiver#onSend} method.
     * This method returns a {@link MidiDevice.MidiConnection} object, which can be used
     * to close the connection.
     *
     * @param inputPort the inputPort to connect
     * @param outputPortNumber the port number of the output port to connect inputPort to.
     * @return {@link MidiDevice.MidiConnection} object if the connection is successful,
     *         or null in case of failure.
     */
    public MidiConnection connectPorts(MidiInputPort inputPort, int outputPortNumber) {
        if (outputPortNumber < 0 || outputPortNumber >= mDeviceInfo.getOutputPortCount()) {
            throw new IllegalArgumentException("outputPortNumber out of range");
        }
        if (mIsDeviceClosed) {
            return null;
        }

        ParcelFileDescriptor pfd = inputPort.claimFileDescriptor();
        if (pfd == null) {
            return null;
        }
        try {
            IBinder token = new Binder();
            int calleePid = mDeviceServer.connectPorts(token, pfd, outputPortNumber);
            // If the service is a different Process then it will duplicate the pfd
            // and we can safely close this one.
            // But if the service is in the same Process then closing the pfd will
            // kill the connection. So don't do that.
            if (calleePid != Process.myPid()) {
                // close our copy of the file descriptor
                IoUtils.closeQuietly(pfd);
            }

            return new MidiConnection(token, inputPort);
        } catch (RemoteException e) {
            Log.e(TAG, "RemoteException in connectPorts");
            return null;
        }
    }


Number 402:
API Relative Path:
src.android.media.midi.MidiSender.java-connect(MidiReceiver)
Corresponding Source:
/**
     * Called to disconnect a {@link MidiReceiver} from the sender
     *
     * @param receiver the receiver to disconnect
     */
    abstract public void onDisconnect(MidiReceiver receiver);


Number 403:
API Relative Path:
src.android.media.midi.MidiSender.java-disconnect(MidiReceiver)
Corresponding Source:
/**
     * Called to disconnect a {@link MidiReceiver} from the sender
     *
     * @param receiver the receiver to disconnect
     */
    abstract public void onDisconnect(MidiReceiver receiver);


Number 404:
API Relative Path:
src.android.media.PlaybackParams.java-setPitch(float)
Corresponding Source:
/**
     * Sets the pitch factor.
     * @param pitch
     * @return this <code>PlaybackParams</code> instance.
     * @throws InvalidArgumentException if the pitch is negative
     */
    public PlaybackParams setPitch(float pitch) {
        if (pitch < 0.f) {
            throw new IllegalArgumentException("pitch must not be negative");
        }
        mPitch = pitch;
        mSet |= SET_PITCH;
        return this;
    }


Number 405:
API Relative Path:
src.android.media.projection.MediaProjection.java-registerCallback(Callback-Handler)
Corresponding Source:
/** Register a listener to receive notifications about when the {@link
     * MediaProjection} changes state.
     *
     * @param callback The callback to call.
     * @param handler The handler on which the callback should be invoked, or
     * null if the callback should be invoked on the calling thread's looper.
     *
     * @see #unregisterCallback
     */
    public void registerCallback(Callback callback, Handler handler) {
        if (callback == null) {
            throw new IllegalArgumentException("callback should not be null");
        }
        if (handler == null) {
            handler = new Handler();
        }
        mCallbacks.put(callback, new CallbackRecord(callback, handler));
    }


Number 406:
API Relative Path:
src.android.media.projection.MediaProjection.java-unregisterCallback(Callback)
Corresponding Source:
/** Unregister a MediaProjection listener.
     *
     * @param callback The callback to unregister.
     *
     * @see #registerCallback
     */
    public void unregisterCallback(Callback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback should not be null");
        }
        mCallbacks.remove(callback);
    }


Number 407:
API Relative Path:
src.android.media.projection.MediaProjectionManager.java-addCallback(Callback-Handler)
Corresponding Source:
/**
     * Add a callback to monitor all of the {@link MediaProjection}s activity.
     * Not for use by regular applications, must have the MANAGE_MEDIA_PROJECTION permission.
     * @hide
     */
    public void addCallback(@NonNull Callback callback, @Nullable Handler handler) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null");
        }
        CallbackDelegate delegate = new CallbackDelegate(callback, handler);
        mCallbacks.put(callback, delegate);
        try {
            mService.addCallback(delegate);
        } catch (RemoteException e) {
            Log.e(TAG, "Unable to add callbacks to MediaProjection service", e);
        }
    }


Number 408:
API Relative Path:
src.android.media.projection.MediaProjectionManager.java-getMediaProjection(int-Intent)
Corresponding Source:
/**
     * Retrieve the MediaProjection obtained from a succesful screen
     * capture request. Will be null if the result from the
     * startActivityForResult() is anything other than RESULT_OK.
     *
     * @param resultCode The result code from {@link android.app.Activity#onActivityResult(int,
     * int, android.content.Intent)}
     * @param resultData The resulting data from {@link android.app.Activity#onActivityResult(int,
     * int, android.content.Intent)}
     */
    public MediaProjection getMediaProjection(int resultCode, @NonNull Intent resultData) {
        if (resultCode != Activity.RESULT_OK || resultData == null) {
            return null;
        }
        IBinder projection = resultData.getIBinderExtra(EXTRA_MEDIA_PROJECTION);
        if (projection == null) {
            return null;
        }
        return new MediaProjection(mContext, IMediaProjection.Stub.asInterface(projection));
    }


Number 409:
API Relative Path:
src.android.media.projection.MediaProjectionManager.java-removeCallback(Callback)
Corresponding Source:
/**
     * Remove a MediaProjection monitoring callback.
     * @hide
     */
    public void removeCallback(@NonNull Callback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null");
        }
        CallbackDelegate delegate = mCallbacks.remove(callback);
        try {
            if (delegate != null) {
                mService.removeCallback(delegate);
            }
        } catch (RemoteException e) {
            Log.e(TAG, "Unable to add callbacks to MediaProjection service", e);
        }
    }


Number 410:
API Relative Path:
src.android.media.RemoteController.java-RemoteController(Context-OnClientUpdateListener-Looper)
Corresponding Source:
/**
     * Class constructor.
     * @param context the {@link Context}, must be non-null.
     * @param updateListener the listener to be called whenever new client information is available,
     *     must be non-null.
     * @param looper the {@link Looper} on which to run the event loop,
     *     or null to use the current thread's looper.
     * @throws java.lang.IllegalArgumentException
     */
    public RemoteController(Context context, OnClientUpdateListener updateListener, Looper looper)
            throws IllegalArgumentException {
        if (context == null) {
            throw new IllegalArgumentException("Invalid null Context");
        }
        if (updateListener == null) {
            throw new IllegalArgumentException("Invalid null OnClientUpdateListener");
        }
        if (looper != null) {
            mEventHandler = new EventHandler(this, looper);
        } else {
            Looper l = Looper.myLooper();
            if (l != null) {
                mEventHandler = new EventHandler(this, l);
            } else {
                throw new IllegalArgumentException("Calling thread not associated with a looper");
            }
        }
        mOnClientUpdateListener = updateListener;
        mContext = context;
        mSessionManager = (MediaSessionManager) context
                .getSystemService(Context.MEDIA_SESSION_SERVICE);
        mSessionListener = new TopTransportSessionListener();

        if (ActivityManager.isLowRamDeviceStatic()) {
            mMaxBitmapDimension = MAX_BITMAP_DIMENSION;
        } else {
            final DisplayMetrics dm = context.getResources().getDisplayMetrics();
            mMaxBitmapDimension = Math.max(dm.widthPixels, dm.heightPixels);
        }
    }


Number 411:
API Relative Path:
src.android.media.RemoteController.java-seekTo(long)
Corresponding Source:
/**
     * Sets the new playback position.
     * This method can only be called on a registered RemoteController.
     * @param timeMs a 0 or positive value for the new playback position, expressed in ms.
     * @return true if the command to set the playback position was successfully sent.
     * @throws IllegalArgumentException
     */
    public boolean seekTo(long timeMs) throws IllegalArgumentException {
        if (!mEnabled) {
            Log.e(TAG, "Cannot use seekTo() from a disabled RemoteController");
            return false;
        }
        if (timeMs < 0) {
            throw new IllegalArgumentException("illegal negative time value");
        }
        synchronized (mInfoLock) {
            if (mCurrentSession != null) {
                mCurrentSession.getTransportControls().seekTo(timeMs);
            }
        }
        return true;
    }


Number 412:
API Relative Path:
src.android.media.RemoteController.java-setArtworkConfiguration(boolean-int-int)
Corresponding Source:
/**
     * @hide
     * @param wantBitmap
     * @param width
     * @param height
     * @return true if successful
     * @throws IllegalArgumentException
     */
    public boolean setArtworkConfiguration(boolean wantBitmap, int width, int height)
            throws IllegalArgumentException {
        synchronized (mInfoLock) {
            if (wantBitmap) {
                if ((width > 0) && (height > 0)) {
                    if (width > mMaxBitmapDimension) { width = mMaxBitmapDimension; }
                    if (height > mMaxBitmapDimension) { height = mMaxBitmapDimension; }
                    mArtworkWidth = width;
                    mArtworkHeight = height;
                } else {
                    throw new IllegalArgumentException("Invalid dimensions");
                }
            } else {
                mArtworkWidth = -1;
                mArtworkHeight = -1;
            }
        }
        return true;
    }


Number 413:
API Relative Path:
src.android.media.RemoteController.java-setSynchronizationMode(int)
Corresponding Source:
/**
     * Set the playback position synchronization mode.
     * Must be called on a registered RemoteController.
     * @param sync {@link #POSITION_SYNCHRONIZATION_NONE} or {@link #POSITION_SYNCHRONIZATION_CHECK}
     * @return true if the synchronization mode was successfully set.
     * @throws IllegalArgumentException
     */
    public boolean setSynchronizationMode(int sync) throws IllegalArgumentException {
        if ((sync != POSITION_SYNCHRONIZATION_NONE) && (sync != POSITION_SYNCHRONIZATION_CHECK)) {
            throw new IllegalArgumentException("Unknown synchronization mode " + sync);
        }
        if (!mIsRegistered) {
            Log.e(TAG, "Cannot set synchronization mode on an unregistered RemoteController");
            return false;
        }
        // deprecated, no-op
        return true;
    }


Number 414:
API Relative Path:
src.android.media.RemoteDisplay.java-listen(String-Listener-Handler-String)
Corresponding Source:
/**
     * Starts listening for displays to be connected on the specified interface.
     *
     * @param iface The interface address and port in the form "x.x.x.x:y".
     * @param listener The listener to invoke when displays are connected or disconnected.
     * @param handler The handler on which to invoke the listener.
     */
    public static RemoteDisplay listen(String iface, Listener listener, Handler handler,
            String opPackageName) {
        if (iface == null) {
            throw new IllegalArgumentException("iface must not be null");
        }
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        if (handler == null) {
            throw new IllegalArgumentException("handler must not be null");
        }

        RemoteDisplay display = new RemoteDisplay(listener, handler, opPackageName);
        display.startListening(iface);
        return display;
    }


Number 415:
API Relative Path:
src.android.media.RemoteDisplay.java-listen(String-Listener-Handler-String)
Corresponding Source:
/**
     * Starts listening for displays to be connected on the specified interface.
     *
     * @param iface The interface address and port in the form "x.x.x.x:y".
     * @param listener The listener to invoke when displays are connected or disconnected.
     * @param handler The handler on which to invoke the listener.
     */
    public static RemoteDisplay listen(String iface, Listener listener, Handler handler,
            String opPackageName) {
        if (iface == null) {
            throw new IllegalArgumentException("iface must not be null");
        }
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        if (handler == null) {
            throw new IllegalArgumentException("handler must not be null");
        }

        RemoteDisplay display = new RemoteDisplay(listener, handler, opPackageName);
        display.startListening(iface);
        return display;
    }


Number 416:
API Relative Path:
src.android.media.RemoteDisplay.java-listen(String-Listener-Handler-String)
Corresponding Source:
/**
     * Starts listening for displays to be connected on the specified interface.
     *
     * @param iface The interface address and port in the form "x.x.x.x:y".
     * @param listener The listener to invoke when displays are connected or disconnected.
     * @param handler The handler on which to invoke the listener.
     */
    public static RemoteDisplay listen(String iface, Listener listener, Handler handler,
            String opPackageName) {
        if (iface == null) {
            throw new IllegalArgumentException("iface must not be null");
        }
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        if (handler == null) {
            throw new IllegalArgumentException("handler must not be null");
        }

        RemoteDisplay display = new RemoteDisplay(listener, handler, opPackageName);
        display.startListening(iface);
        return display;
    }


Number 417:
API Relative Path:
src.android.media.ResampleInputStream.java-ResampleInputStream(InputStream-int-int)
Corresponding Source:
/**
     * Create a new ResampleInputStream, which converts the sample rate
     * @param inputStream InputStream containing 16 bit PCM.
     * @param rateIn the input sample rate.
     * @param rateOut the output sample rate.
     * This only handles rateIn == rateOut / 2 for the moment.
     */
    public ResampleInputStream(InputStream inputStream, int rateIn, int rateOut) {
        // only support 2:1 at the moment
        if (rateIn != 2 * rateOut) throw new IllegalArgumentException("only support 2:1 at the moment");
        rateIn = 2;
        rateOut = 1;

        mInputStream = inputStream;
        mRateIn = rateIn;
        mRateOut = rateOut;
    }


Number 418:
API Relative Path:
src.android.media.RingtoneManager.java-getRingtoneUri(int)
Corresponding Source:
/**
     * Gets a {@link Uri} for the ringtone at the given position in the {@link Cursor}.
     * 
     * @param position The position (in the {@link Cursor}) of the ringtone.
     * @return A {@link Uri} pointing to the ringtone.
     */
    public Uri getRingtoneUri(int position) {
        // use cursor directly instead of requerying it, which could easily
        // cause position to shuffle.
        if (mCursor == null || !mCursor.moveToPosition(position)) {
            return null;
        }
        
        return getUriFromCursor(mCursor);
    }


Number 419:
API Relative Path:
src.android.media.session.MediaController.java-dispatchMediaButtonEvent(KeyEvent)
Corresponding Source:
/**
     * Send the specified media button event to the session. Only media keys can
     * be sent by this method, other keys will be ignored.
     *
     * @param keyEvent The media button event to dispatch.
     * @return true if the event was sent to the session, false otherwise.
     */
    public boolean dispatchMediaButtonEvent(@NonNull KeyEvent keyEvent) {
        if (keyEvent == null) {
            throw new IllegalArgumentException("KeyEvent may not be null");
        }
        if (!KeyEvent.isMediaKey(keyEvent.getKeyCode())) {
            return false;
        }
        try {
            return mSessionBinder.sendMediaButton(keyEvent);
        } catch (RemoteException e) {
            // System is dead. =(
        }
        return false;
    }


Number 420:
API Relative Path:
src.android.media.session.MediaController.java-MediaController(Context-ISessionController)
Corresponding Source:
/**
     * Call for creating a MediaController directly from a binder. Should only
     * be used by framework code.
     *
     * @hide
     */
    public MediaController(Context context, ISessionController sessionBinder) {
        if (sessionBinder == null) {
            throw new IllegalArgumentException("Session token cannot be null");
        }
        if (context == null) {
            throw new IllegalArgumentException("Context cannot be null");
        }
        mSessionBinder = sessionBinder;
        mTransportControls = new TransportControls();
        mToken = new MediaSession.Token(sessionBinder);
        mContext = context;
    }


Number 421:
API Relative Path:
src.android.media.session.MediaController.java-MediaController(Context-ISessionController)
Corresponding Source:
/**
     * Call for creating a MediaController directly from a binder. Should only
     * be used by framework code.
     *
     * @hide
     */
    public MediaController(Context context, ISessionController sessionBinder) {
        if (sessionBinder == null) {
            throw new IllegalArgumentException("Session token cannot be null");
        }
        if (context == null) {
            throw new IllegalArgumentException("Context cannot be null");
        }
        mSessionBinder = sessionBinder;
        mTransportControls = new TransportControls();
        mToken = new MediaSession.Token(sessionBinder);
        mContext = context;
    }


Number 422:
API Relative Path:
src.android.media.session.MediaController.java-unregisterCallback(Callback)
Corresponding Source:
/**
     * Unregisters the specified callback. If an update has already been posted
     * you may still receive it after calling this method.
     *
     * @param callback The callback to remove.
     */
    public void unregisterCallback(@NonNull Callback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null");
        }
        synchronized (mLock) {
            removeCallbackLocked(callback);
        }
    }


Number 423:
API Relative Path:
src.android.media.session.MediaSession.java-MediaSession(Context-String-int)
Corresponding Source:
/**
     * Creates a new session as the specified user. To create a session as a
     * user other than your own you must hold the
     * {@link android.Manifest.permission#INTERACT_ACROSS_USERS_FULL}
     * permission.
     *
     * @param context The context to use to create the session.
     * @param tag A short name for debugging purposes.
     * @param userId The user id to create the session as.
     * @hide
     */
    public MediaSession(@NonNull Context context, @NonNull String tag, int userId) {
        if (context == null) {
            throw new IllegalArgumentException("context cannot be null.");
        }
        if (TextUtils.isEmpty(tag)) {
            throw new IllegalArgumentException("tag cannot be null or empty");
        }
        mMaxBitmapSize = context.getResources().getDimensionPixelSize(
                com.android.internal.R.dimen.config_mediaMetadataBitmapMaxSize);
        mCbStub = new CallbackStub(this);
        MediaSessionManager manager = (MediaSessionManager) context
                .getSystemService(Context.MEDIA_SESSION_SERVICE);
        try {
            mBinder = manager.createSession(mCbStub, tag, userId);
            mSessionToken = new Token(mBinder.getController());
            mController = new MediaController(context, mSessionToken);
        } catch (RemoteException e) {
            throw new RuntimeException("Remote error creating session.", e);
        }
    }


Number 424:
API Relative Path:
src.android.media.session.MediaSession.java-setCallback(Callback-Handler)
Corresponding Source:
/**
     * Set the callback to receive updates for the MediaSession. This includes
     * media button events and transport controls.
     * <p>
     * Set the callback to null to stop receiving updates.
     *
     * @param callback The callback to receive updates on.
     * @param handler The handler that events should be posted on.
     */
    public void setCallback(@Nullable Callback callback, @Nullable Handler handler) {
        synchronized (mLock) {
            if (callback == null) {
                if (mCallback != null) {
                    mCallback.mCallback.mSession = null;
                }
                mCallback = null;
                return;
            }
            if (mCallback != null) {
                // We're updating the callback, clear the session from the old
                // one.
                mCallback.mCallback.mSession = null;
            }
            if (handler == null) {
                handler = new Handler();
            }
            callback.mSession = this;
            CallbackMessageHandler msgHandler = new CallbackMessageHandler(handler.getLooper(),
                    callback);
            mCallback = msgHandler;
        }
    }


Number 425:
API Relative Path:
src.android.media.session.MediaSession.java-setPlaybackToLocal(AudioAttributes)
Corresponding Source:
/**
     * Set the attributes for this session's audio. This will affect the
     * system's volume handling for this session. If
     * {@link #setPlaybackToRemote} was previously called it will stop receiving
     * volume commands and the system will begin sending volume changes to the
     * appropriate stream.
     * <p>
     * By default sessions use attributes for media.
     *
     * @param attributes The {@link AudioAttributes} for this session's audio.
     */
    public void setPlaybackToLocal(AudioAttributes attributes) {
        if (attributes == null) {
            throw new IllegalArgumentException("Attributes cannot be null for local playback.");
        }
        try {
            mBinder.setPlaybackToLocal(attributes);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Failure in setPlaybackToLocal.", e);
        }
    }


Number 426:
API Relative Path:
src.android.media.session.MediaSessionManager.java-addOnActiveSessionsChangedListener(OnActiveSessionsChangedListener-ComponentName-int-Handler)
Corresponding Source:
/**
     * Add a listener to be notified when the list of active sessions
     * changes.This requires the
     * android.Manifest.permission.MEDIA_CONTENT_CONTROL permission be held by
     * the calling app. You may also retrieve this list if your app is an
     * enabled notification listener using the
     * {@link NotificationListenerService} APIs, in which case you must pass the
     * {@link ComponentName} of your enabled listener.
     *
     * @param sessionListener The listener to add.
     * @param notificationListener The enabled notification listener component.
     *            May be null.
     * @param userId The userId to listen for changes on.
     * @param handler The handler to post updates on.
     * @hide
     */
    public void addOnActiveSessionsChangedListener(
            @NonNull OnActiveSessionsChangedListener sessionListener,
            @Nullable ComponentName notificationListener, int userId, @Nullable Handler handler) {
        if (sessionListener == null) {
            throw new IllegalArgumentException("listener may not be null");
        }
        if (handler == null) {
            handler = new Handler();
        }
        synchronized (mLock) {
            if (mListeners.get(sessionListener) != null) {
                Log.w(TAG, "Attempted to add session listener twice, ignoring.");
                return;
            }
            SessionsChangedWrapper wrapper = new SessionsChangedWrapper(mContext, sessionListener,
                    handler);
            try {
                mService.addSessionsListener(wrapper.mStub, notificationListener, userId);
                mListeners.put(sessionListener, wrapper);
            } catch (RemoteException e) {
                Log.e(TAG, "Error in addOnActiveSessionsChangedListener.", e);
            }
        }
    }


Number 427:
API Relative Path:
src.android.media.session.MediaSessionManager.java-removeOnActiveSessionsChangedListener(OnActiveSessionsChangedListener)
Corresponding Source:
/**
     * Stop receiving active sessions updates on the specified listener.
     *
     * @param listener The listener to remove.
     */
    public void removeOnActiveSessionsChangedListener(
            @NonNull OnActiveSessionsChangedListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener may not be null");
        }
        synchronized (mLock) {
            SessionsChangedWrapper wrapper = mListeners.remove(listener);
            if (wrapper != null) {
                try {
                    mService.removeSessionsListener(wrapper.mStub);
                } catch (RemoteException e) {
                    Log.e(TAG, "Error in removeOnActiveSessionsChangedListener.", e);
                } finally {
                    wrapper.release();
                }
            }
        }
    }


Number 428:
API Relative Path:
src.android.media.SoundPool.java-load(AssetFileDescriptor-int)
Corresponding Source:
/**
     * Load the sound from an asset file descriptor.
     *
     * @param afd an asset file descriptor
     * @param priority the priority of the sound. Currently has no effect. Use
     *                 a value of 1 for future compatibility.
     * @return a sound ID. This value can be used to play or unload the sound.
     */
    public int load(AssetFileDescriptor afd, int priority) {
        if (afd != null) {
            long len = afd.getLength();
            if (len < 0) {
                throw new AndroidRuntimeException("no length for fd");
            }
            return _load(afd.getFileDescriptor(), afd.getStartOffset(), len, priority);
        } else {
            return 0;
        }
    }


Number 429:
API Relative Path:
src.android.media.SyncParams.java-setTolerance(float)
Corresponding Source:
/**
     * Sets the tolerance. The default tolerance is platform specific, but is never more than 1/24.
     * @param tolerance A non-negative number representing
     *     the maximum deviation of the playback rate from the playback rate
     *     set. ({@code abs(actual_rate - set_rate) / set_rate})
     * @return this <code>SyncParams</code> instance.
     * @throws InvalidArgumentException if the tolerance is negative, or not less than one
     */
    public SyncParams setTolerance(float tolerance) {
        if (tolerance < 0.f || tolerance >= 1.f) {
            throw new IllegalArgumentException("tolerance must be less than one and non-negative");
        }
        mTolerance = tolerance;
        mSet |= SET_TOLERANCE;
        return this;
    }


Number 430:
API Relative Path:
src.android.media.ThumbnailUtils.java-extractThumbnail(Bitmap-int-int-int)
Corresponding Source:
/**
     * Creates a centered bitmap of the desired size.
     *
     * @param source original bitmap source
     * @param width targeted width
     * @param height targeted height
     * @param options options used during thumbnail extraction
     */
    public static Bitmap extractThumbnail(
            Bitmap source, int width, int height, int options) {
        if (source == null) {
            return null;
        }

        float scale;
        if (source.getWidth() < source.getHeight()) {
            scale = width / (float) source.getWidth();
        } else {
            scale = height / (float) source.getHeight();
        }
        Matrix matrix = new Matrix();
        matrix.setScale(scale, scale);
        Bitmap thumbnail = transform(matrix, source, width, height,
                OPTIONS_SCALE_UP | options);
        return thumbnail;
    }


Number 431:
API Relative Path:
src.android.media.tv.TvInputInfo.java-loadIcon(Context-int)
Corresponding Source:
/**
     * Loads the user-displayed icon for this TV input per input state.
     *
     * @param context Supplies a {@link Context} used to load the icon.
     * @param state The input state. Should be one of the followings.
     *              {@link TvInputManager#INPUT_STATE_CONNECTED},
     *              {@link TvInputManager#INPUT_STATE_CONNECTED_STANDBY} and
     *              {@link TvInputManager#INPUT_STATE_DISCONNECTED}.
     * @return a Drawable containing the TV input's icon for the given state or {@code null} if such
     *         an icon is not defined.
     * @hide
     */
    @SystemApi
    public Drawable loadIcon(@NonNull Context context, int state) {
        if (state == TvInputManager.INPUT_STATE_CONNECTED) {
            return loadIcon(context);
        } else if (state == TvInputManager.INPUT_STATE_CONNECTED_STANDBY) {
            if (mIconStandby != null) {
                return mIconStandby.loadDrawable(context);
            }
        } else if (state == TvInputManager.INPUT_STATE_DISCONNECTED) {
            if (mIconDisconnected != null) {
                return mIconDisconnected.loadDrawable(context);
            }
        } else {
            throw new IllegalArgumentException("Unknown state: " + state);
        }
        return null;
    }


Number 432:
API Relative Path:
src.android.net.apf.ApfGenerator.java-addJumpIfBytesNotEqual(Register-byte[]-String)
Corresponding Source:
/**
     * Add an instruction to the end of the program to jump to {@code target} if the bytes of the
     * packet at, an offset specified by {@code register}, match {@code bytes}.
     */
    public ApfGenerator addJumpIfBytesNotEqual(Register register, byte[] bytes, String target)
            throws IllegalInstructionException {
        if (register == Register.R1) {
            throw new IllegalInstructionException("JNEBS fails with R1");
        }
        Instruction instruction = new Instruction(Opcodes.JNEBS, register);
        instruction.setUnsignedImm(bytes.length);
        instruction.setTargetLabel(target);
        instruction.setCompareBytes(bytes);
        addInstruction(instruction);
        return this;
    }


Number 433:
API Relative Path:
src.android.net.apf.ApfGenerator.java-addLoadFromMemory(Register-int)
Corresponding Source:
/**
     * Add an instruction to the end of the program to load memory slot {@code slot} into
     * {@code register}.
     */
    public ApfGenerator addLoadFromMemory(Register register, int slot)
            throws IllegalInstructionException {
        if (slot < 0 || slot > (MEMORY_SLOTS - 1)) {
            throw new IllegalInstructionException("illegal memory slot number: " + slot);
        }
        Instruction instruction = new Instruction(Opcodes.EXT, register);
        instruction.setUnsignedImm(ExtendedOpcodes.LDM.value + slot);
        addInstruction(instruction);
        return this;
    }


Number 434:
API Relative Path:
src.android.net.apf.ApfGenerator.java-addStoreToMemory(Register-int)
Corresponding Source:
/**
     * Add an instruction to the end of the program to store {@code register} into memory slot
     * {@code slot}.
     */
    public ApfGenerator addStoreToMemory(Register register, int slot)
            throws IllegalInstructionException {
        if (slot < 0 || slot > (MEMORY_SLOTS - 1)) {
            throw new IllegalInstructionException("illegal memory slot number: " + slot);
        }
        Instruction instruction = new Instruction(Opcodes.EXT, register);
        instruction.setUnsignedImm(ExtendedOpcodes.STM.value + slot);
        addInstruction(instruction);
        return this;
    }


Number 435:
API Relative Path:
src.android.net.ConnectivityManager.java-unregisterNetworkCallback(NetworkCallback)
Corresponding Source:
/**
     * Unregisters callbacks about and possibly releases networks originating from
     * {@link #requestNetwork(NetworkRequest, NetworkCallback)} and
     * {@link #registerNetworkCallback(NetworkRequest, NetworkCallback)} calls.
     * If the given {@code NetworkCallback} had previously been used with
     * {@code #requestNetwork}, any networks that had been connected to only to satisfy that request
     * will be disconnected.
     *
     * @param networkCallback The {@link NetworkCallback} used when making the request.
     */
    public void unregisterNetworkCallback(NetworkCallback networkCallback) {
        if (networkCallback == null || networkCallback.networkRequest == null ||
                networkCallback.networkRequest.requestId == REQUEST_ID_UNSET) {
            throw new IllegalArgumentException("Invalid NetworkCallback");
        }
        try {
            mService.releaseNetworkRequest(networkCallback.networkRequest);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }

        synchronized (sNetworkCallback) {
            sNetworkCallback.remove(networkCallback.networkRequest);
        }
    }


Number 436:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-addTlv(ByteBuffer-byte-byte[])
Corresponding Source:
/**
     * Adds an optional parameter containing an array of bytes.
     */
    protected static void addTlv(ByteBuffer buf, byte type, byte[] payload) {
        if (payload != null) {
            if (payload.length > MAX_OPTION_LEN) {
                throw new IllegalArgumentException("DHCP option too long: "
                        + payload.length + " vs. " + MAX_OPTION_LEN);
            }
            buf.put(type);
            buf.put((byte) payload.length);
            buf.put(payload);
        }
    }


Number 437:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-addTlv(ByteBuffer-byte-byte[])
Corresponding Source:
/**
     * Adds an optional parameter containing an array of bytes.
     */
    protected static void addTlv(ByteBuffer buf, byte type, byte[] payload) {
        if (payload != null) {
            if (payload.length > MAX_OPTION_LEN) {
                throw new IllegalArgumentException("DHCP option too long: "
                        + payload.length + " vs. " + MAX_OPTION_LEN);
            }
            buf.put(type);
            buf.put((byte) payload.length);
            buf.put(payload);
        }
    }


Number 438:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-addTlv(ByteBuffer-byte-Inet4Address)
Corresponding Source:
/**
     * Adds an optional parameter containing an IP address.
     */
    protected static void addTlv(ByteBuffer buf, byte type, Inet4Address addr) {
        if (addr != null) {
            addTlv(buf, type, addr.getAddress());
        }
    }


Number 439:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-addTlv(ByteBuffer-byte-Integer)
Corresponding Source:
/**
     * Adds an optional parameter containing a simple integer
     */
    protected static void addTlv(ByteBuffer buf, byte type, Integer value) {
        if (value != null) {
            buf.put(type);
            buf.put((byte) 4);
            buf.putInt(value.intValue());
        }
    }


Number 440:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-addTlv(ByteBuffer-byte-List)
Corresponding Source:
/**
     * Adds an optional parameter containing a list of IP addresses.
     */
    protected static void addTlv(ByteBuffer buf, byte type, List<Inet4Address> addrs) {
        if (addrs == null || addrs.size() == 0) return;

        int optionLen = 4 * addrs.size();
        if (optionLen > MAX_OPTION_LEN) {
            throw new IllegalArgumentException("DHCP option too long: "
                    + optionLen + " vs. " + MAX_OPTION_LEN);
        }

        buf.put(type);
        buf.put((byte)(optionLen));

        for (Inet4Address addr : addrs) {
            buf.put(addr.getAddress());
        }
    }


Number 441:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-addTlv(ByteBuffer-byte-Short)
Corresponding Source:
/**
     * Adds an optional parameter containing a short integer
     */
    protected static void addTlv(ByteBuffer buf, byte type, Short value) {
        if (value != null) {
            buf.put(type);
            buf.put((byte) 2);
            buf.putShort(value.shortValue());
        }
    }


Number 442:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-decodeFullPacket(ByteBuffer-int)
Corresponding Source:
/**
     * Creates a concrete DhcpPacket from the supplied ByteBuffer.  The
     * buffer may have an L2 encapsulation (which is the full EthernetII
     * format starting with the source-address MAC) or an L3 encapsulation
     * (which starts with the IP header).
     * <br>
     * A subset of the optional parameters are parsed and are stored
     * in object fields.
     */
    public static DhcpPacket decodeFullPacket(ByteBuffer packet, int pktType) throws ParseException
    {
        // bootp parameters
        int transactionId;
        short secs;
        Inet4Address clientIp;
        Inet4Address yourIp;
        Inet4Address nextIp;
        Inet4Address relayIp;
        byte[] clientMac;
        List<Inet4Address> dnsServers = new ArrayList<>();
        List<Inet4Address> gateways = new ArrayList<>();  // aka router
        Inet4Address serverIdentifier = null;
        Inet4Address netMask = null;
        String message = null;
        String vendorId = null;
        String vendorInfo = null;
        byte[] expectedParams = null;
        String hostName = null;
        String domainName = null;
        Inet4Address ipSrc = null;
        Inet4Address ipDst = null;
        Inet4Address bcAddr = null;
        Inet4Address requestedIp = null;

        // The following are all unsigned integers. Internally we store them as signed integers of
        // the same length because that way we're guaranteed that they can't be out of the range of
        // the unsigned field in the packet. Callers wanting to pass in an unsigned value will need
        // to cast it.
        Short mtu = null;
        Short maxMessageSize = null;
        Integer leaseTime = null;
        Integer T1 = null;
        Integer T2 = null;

        // dhcp options
        byte dhcpType = (byte) 0xFF;

        packet.order(ByteOrder.BIG_ENDIAN);

        // check to see if we need to parse L2, IP, and UDP encaps
        if (pktType == ENCAP_L2) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L2) {
                throw new ParseException(DhcpErrorEvent.L2_TOO_SHORT,
                        "L2 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L2);
            }

            byte[] l2dst = new byte[6];
            byte[] l2src = new byte[6];

            packet.get(l2dst);
            packet.get(l2src);

            short l2type = packet.getShort();

            if (l2type != OsConstants.ETH_P_IP) {
                throw new ParseException(DhcpErrorEvent.L2_WRONG_ETH_TYPE,
                        "Unexpected L2 type 0x%04x, expected 0x%04x", l2type, OsConstants.ETH_P_IP);
            }
        }

        if (pktType <= ENCAP_L3) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L3) {
                throw new ParseException(DhcpErrorEvent.L3_TOO_SHORT,
                        "L3 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L3);
            }

            byte ipTypeAndLength = packet.get();
            int ipVersion = (ipTypeAndLength & 0xf0) >> 4;
            if (ipVersion != 4) {
                throw new ParseException(
                        DhcpErrorEvent.L3_NOT_IPV4, "Invalid IP version %d", ipVersion);
            }

            // System.out.println("ipType is " + ipType);
            byte ipDiffServicesField = packet.get();
            short ipTotalLength = packet.getShort();
            short ipIdentification = packet.getShort();
            byte ipFlags = packet.get();
            byte ipFragOffset = packet.get();
            byte ipTTL = packet.get();
            byte ipProto = packet.get();
            short ipChksm = packet.getShort();

            ipSrc = readIpAddress(packet);
            ipDst = readIpAddress(packet);

            if (ipProto != IP_TYPE_UDP) {
                throw new ParseException(
                        DhcpErrorEvent.L4_NOT_UDP, "Protocol not UDP: %d", ipProto);
            }

            // Skip options. This cannot cause us to read beyond the end of the buffer because the
            // IPv4 header cannot be more than (0x0f * 4) = 60 bytes long, and that is less than
            // MIN_PACKET_LENGTH_L3.
            int optionWords = ((ipTypeAndLength & 0x0f) - 5);
            for (int i = 0; i < optionWords; i++) {
                packet.getInt();
            }

            // assume UDP
            short udpSrcPort = packet.getShort();
            short udpDstPort = packet.getShort();
            short udpLen = packet.getShort();
            short udpChkSum = packet.getShort();

            // Only accept packets to or from the well-known client port (expressly permitting
            // packets from ports other than the well-known server port; http://b/24687559), and
            // server-to-server packets, e.g. for relays.
            if (!isPacketToOrFromClient(udpSrcPort, udpDstPort) &&
                !isPacketServerToServer(udpSrcPort, udpDstPort)) {
                // This should almost never happen because we use SO_ATTACH_FILTER on the packet
                // socket to drop packets that don't have the right source ports. However, it's
                // possible that a packet arrives between when the socket is bound and when the
                // filter is set. http://b/26696823 .
                throw new ParseException(DhcpErrorEvent.L4_WRONG_PORT,
                        "Unexpected UDP ports %d->%d", udpSrcPort, udpDstPort);
            }
        }

        // We need to check the length even for ENCAP_L3 because the IPv4 header is variable-length.
        if (pktType > ENCAP_BOOTP || packet.remaining() < MIN_PACKET_LENGTH_BOOTP) {
            throw new ParseException(DhcpErrorEvent.BOOTP_TOO_SHORT,
                        "Invalid type or BOOTP packet too short, %d < %d",
                        packet.remaining(), MIN_PACKET_LENGTH_BOOTP);
        }

        byte type = packet.get();
        byte hwType = packet.get();
        int addrLen = packet.get() & 0xff;
        byte hops = packet.get();
        transactionId = packet.getInt();
        secs = packet.getShort();
        short bootpFlags = packet.getShort();
        boolean broadcast = (bootpFlags & 0x8000) != 0;
        byte[] ipv4addr = new byte[4];

        try {
            packet.get(ipv4addr);
            clientIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            yourIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            nextIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            relayIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
        } catch (UnknownHostException ex) {
            throw new ParseException(DhcpErrorEvent.L3_INVALID_IP,
                    "Invalid IPv4 address: %s", Arrays.toString(ipv4addr));
        }

        // Some DHCP servers have been known to announce invalid client hardware address values such
        // as 0xff. The legacy DHCP client accepted these becuause it does not check the length at
        // all but only checks that the interface MAC address matches the first bytes of the address
        // in the packets. We're a bit stricter: if the length is obviously invalid (i.e., bigger
        // than the size of the field), we fudge it to 6 (Ethernet). http://b/23725795
        // TODO: evaluate whether to make this test more liberal.
        if (addrLen > HWADDR_LEN) {
            addrLen = ETHER_BROADCAST.length;
        }

        clientMac = new byte[addrLen];
        packet.get(clientMac);

        // skip over address padding (16 octets allocated)
        packet.position(packet.position() + (16 - addrLen)
                        + 64    // skip server host name (64 chars)
                        + 128); // skip boot file name (128 chars)

        int dhcpMagicCookie = packet.getInt();

        if (dhcpMagicCookie != DHCP_MAGIC_COOKIE) {
            throw new ParseException(DhcpErrorEvent.DHCP_BAD_MAGIC_COOKIE,
                    "Bad magic cookie 0x%08x, should be 0x%08x",
                    dhcpMagicCookie, DHCP_MAGIC_COOKIE);
        }

        // parse options
        boolean notFinishedOptions = true;

        while ((packet.position() < packet.limit()) && notFinishedOptions) {
            final byte optionType = packet.get(); // cannot underflow because position < limit
            try {
                if (optionType == DHCP_OPTION_END) {
                    notFinishedOptions = false;
                } else if (optionType == DHCP_OPTION_PAD) {
                    // The pad option doesn't have a length field. Nothing to do.
                } else {
                    int optionLen = packet.get() & 0xFF;
                    int expectedLen = 0;

                    switch(optionType) {
                        case DHCP_SUBNET_MASK:
                            netMask = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_ROUTER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                gateways.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_DNS_SERVER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                dnsServers.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_HOST_NAME:
                            expectedLen = optionLen;
                            hostName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MTU:
                            expectedLen = 2;
                            mtu = packet.getShort();
                            break;
                        case DHCP_DOMAIN_NAME:
                            expectedLen = optionLen;
                            domainName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_BROADCAST_ADDRESS:
                            bcAddr = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_REQUESTED_IP:
                            requestedIp = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_LEASE_TIME:
                            leaseTime = Integer.valueOf(packet.getInt());
                            expectedLen = 4;
                            break;
                        case DHCP_MESSAGE_TYPE:
                            dhcpType = packet.get();
                            expectedLen = 1;
                            break;
                        case DHCP_SERVER_IDENTIFIER:
                            serverIdentifier = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_PARAMETER_LIST:
                            expectedParams = new byte[optionLen];
                            packet.get(expectedParams);
                            expectedLen = optionLen;
                            break;
                        case DHCP_MESSAGE:
                            expectedLen = optionLen;
                            message = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MAX_MESSAGE_SIZE:
                            expectedLen = 2;
                            maxMessageSize = Short.valueOf(packet.getShort());
                            break;
                        case DHCP_RENEWAL_TIME:
                            expectedLen = 4;
                            T1 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_REBINDING_TIME:
                            expectedLen = 4;
                            T2 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_VENDOR_CLASS_ID:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorId = readAsciiString(packet, optionLen, true);
                            break;
                        case DHCP_CLIENT_IDENTIFIER: { // Client identifier
                            byte[] id = new byte[optionLen];
                            packet.get(id);
                            expectedLen = optionLen;
                        } break;
                        case DHCP_VENDOR_INFO:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorInfo = readAsciiString(packet, optionLen, true);
                            break;
                        default:
                            // ignore any other parameters
                            for (int i = 0; i < optionLen; i++) {
                                expectedLen++;
                                byte throwaway = packet.get();
                            }
                    }

                    if (expectedLen != optionLen) {
                        final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                                DhcpErrorEvent.DHCP_INVALID_OPTION_LENGTH, optionType);
                        throw new ParseException(errorCode,
                                "Invalid length %d for option %d, expected %d",
                                optionLen, optionType, expectedLen);
                    }
                }
            } catch (BufferUnderflowException e) {
                final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                        DhcpErrorEvent.BUFFER_UNDERFLOW, optionType);
                throw new ParseException(errorCode, "BufferUnderflowException");
            }
        }

        DhcpPacket newPacket;

        switch(dhcpType) {
            case (byte) 0xFF:
                throw new ParseException(DhcpErrorEvent.DHCP_NO_MSG_TYPE,
                        "No DHCP message type option");
            case DHCP_MESSAGE_TYPE_DISCOVER:
                newPacket = new DhcpDiscoverPacket(
                    transactionId, secs, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_OFFER:
                newPacket = new DhcpOfferPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_REQUEST:
                newPacket = new DhcpRequestPacket(
                    transactionId, secs, clientIp, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_DECLINE:
                newPacket = new DhcpDeclinePacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_ACK:
                newPacket = new DhcpAckPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_NAK:
                newPacket = new DhcpNakPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_INFORM:
                newPacket = new DhcpInformPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            default:
                throw new ParseException(DhcpErrorEvent.DHCP_UNKNOWN_MSG_TYPE,
                        "Unimplemented DHCP type %d", dhcpType);
        }

        newPacket.mBroadcastAddress = bcAddr;
        newPacket.mDnsServers = dnsServers;
        newPacket.mDomainName = domainName;
        newPacket.mGateways = gateways;
        newPacket.mHostName = hostName;
        newPacket.mLeaseTime = leaseTime;
        newPacket.mMessage = message;
        newPacket.mMtu = mtu;
        newPacket.mRequestedIp = requestedIp;
        newPacket.mRequestedParams = expectedParams;
        newPacket.mServerIdentifier = serverIdentifier;
        newPacket.mSubnetMask = netMask;
        newPacket.mMaxMessageSize = maxMessageSize;
        newPacket.mT1 = T1;
        newPacket.mT2 = T2;
        newPacket.mVendorId = vendorId;
        newPacket.mVendorInfo = vendorInfo;
        return newPacket;
    }


Number 443:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-decodeFullPacket(ByteBuffer-int)
Corresponding Source:
/**
     * Creates a concrete DhcpPacket from the supplied ByteBuffer.  The
     * buffer may have an L2 encapsulation (which is the full EthernetII
     * format starting with the source-address MAC) or an L3 encapsulation
     * (which starts with the IP header).
     * <br>
     * A subset of the optional parameters are parsed and are stored
     * in object fields.
     */
    public static DhcpPacket decodeFullPacket(ByteBuffer packet, int pktType) throws ParseException
    {
        // bootp parameters
        int transactionId;
        short secs;
        Inet4Address clientIp;
        Inet4Address yourIp;
        Inet4Address nextIp;
        Inet4Address relayIp;
        byte[] clientMac;
        List<Inet4Address> dnsServers = new ArrayList<>();
        List<Inet4Address> gateways = new ArrayList<>();  // aka router
        Inet4Address serverIdentifier = null;
        Inet4Address netMask = null;
        String message = null;
        String vendorId = null;
        String vendorInfo = null;
        byte[] expectedParams = null;
        String hostName = null;
        String domainName = null;
        Inet4Address ipSrc = null;
        Inet4Address ipDst = null;
        Inet4Address bcAddr = null;
        Inet4Address requestedIp = null;

        // The following are all unsigned integers. Internally we store them as signed integers of
        // the same length because that way we're guaranteed that they can't be out of the range of
        // the unsigned field in the packet. Callers wanting to pass in an unsigned value will need
        // to cast it.
        Short mtu = null;
        Short maxMessageSize = null;
        Integer leaseTime = null;
        Integer T1 = null;
        Integer T2 = null;

        // dhcp options
        byte dhcpType = (byte) 0xFF;

        packet.order(ByteOrder.BIG_ENDIAN);

        // check to see if we need to parse L2, IP, and UDP encaps
        if (pktType == ENCAP_L2) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L2) {
                throw new ParseException(DhcpErrorEvent.L2_TOO_SHORT,
                        "L2 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L2);
            }

            byte[] l2dst = new byte[6];
            byte[] l2src = new byte[6];

            packet.get(l2dst);
            packet.get(l2src);

            short l2type = packet.getShort();

            if (l2type != OsConstants.ETH_P_IP) {
                throw new ParseException(DhcpErrorEvent.L2_WRONG_ETH_TYPE,
                        "Unexpected L2 type 0x%04x, expected 0x%04x", l2type, OsConstants.ETH_P_IP);
            }
        }

        if (pktType <= ENCAP_L3) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L3) {
                throw new ParseException(DhcpErrorEvent.L3_TOO_SHORT,
                        "L3 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L3);
            }

            byte ipTypeAndLength = packet.get();
            int ipVersion = (ipTypeAndLength & 0xf0) >> 4;
            if (ipVersion != 4) {
                throw new ParseException(
                        DhcpErrorEvent.L3_NOT_IPV4, "Invalid IP version %d", ipVersion);
            }

            // System.out.println("ipType is " + ipType);
            byte ipDiffServicesField = packet.get();
            short ipTotalLength = packet.getShort();
            short ipIdentification = packet.getShort();
            byte ipFlags = packet.get();
            byte ipFragOffset = packet.get();
            byte ipTTL = packet.get();
            byte ipProto = packet.get();
            short ipChksm = packet.getShort();

            ipSrc = readIpAddress(packet);
            ipDst = readIpAddress(packet);

            if (ipProto != IP_TYPE_UDP) {
                throw new ParseException(
                        DhcpErrorEvent.L4_NOT_UDP, "Protocol not UDP: %d", ipProto);
            }

            // Skip options. This cannot cause us to read beyond the end of the buffer because the
            // IPv4 header cannot be more than (0x0f * 4) = 60 bytes long, and that is less than
            // MIN_PACKET_LENGTH_L3.
            int optionWords = ((ipTypeAndLength & 0x0f) - 5);
            for (int i = 0; i < optionWords; i++) {
                packet.getInt();
            }

            // assume UDP
            short udpSrcPort = packet.getShort();
            short udpDstPort = packet.getShort();
            short udpLen = packet.getShort();
            short udpChkSum = packet.getShort();

            // Only accept packets to or from the well-known client port (expressly permitting
            // packets from ports other than the well-known server port; http://b/24687559), and
            // server-to-server packets, e.g. for relays.
            if (!isPacketToOrFromClient(udpSrcPort, udpDstPort) &&
                !isPacketServerToServer(udpSrcPort, udpDstPort)) {
                // This should almost never happen because we use SO_ATTACH_FILTER on the packet
                // socket to drop packets that don't have the right source ports. However, it's
                // possible that a packet arrives between when the socket is bound and when the
                // filter is set. http://b/26696823 .
                throw new ParseException(DhcpErrorEvent.L4_WRONG_PORT,
                        "Unexpected UDP ports %d->%d", udpSrcPort, udpDstPort);
            }
        }

        // We need to check the length even for ENCAP_L3 because the IPv4 header is variable-length.
        if (pktType > ENCAP_BOOTP || packet.remaining() < MIN_PACKET_LENGTH_BOOTP) {
            throw new ParseException(DhcpErrorEvent.BOOTP_TOO_SHORT,
                        "Invalid type or BOOTP packet too short, %d < %d",
                        packet.remaining(), MIN_PACKET_LENGTH_BOOTP);
        }

        byte type = packet.get();
        byte hwType = packet.get();
        int addrLen = packet.get() & 0xff;
        byte hops = packet.get();
        transactionId = packet.getInt();
        secs = packet.getShort();
        short bootpFlags = packet.getShort();
        boolean broadcast = (bootpFlags & 0x8000) != 0;
        byte[] ipv4addr = new byte[4];

        try {
            packet.get(ipv4addr);
            clientIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            yourIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            nextIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            relayIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
        } catch (UnknownHostException ex) {
            throw new ParseException(DhcpErrorEvent.L3_INVALID_IP,
                    "Invalid IPv4 address: %s", Arrays.toString(ipv4addr));
        }

        // Some DHCP servers have been known to announce invalid client hardware address values such
        // as 0xff. The legacy DHCP client accepted these becuause it does not check the length at
        // all but only checks that the interface MAC address matches the first bytes of the address
        // in the packets. We're a bit stricter: if the length is obviously invalid (i.e., bigger
        // than the size of the field), we fudge it to 6 (Ethernet). http://b/23725795
        // TODO: evaluate whether to make this test more liberal.
        if (addrLen > HWADDR_LEN) {
            addrLen = ETHER_BROADCAST.length;
        }

        clientMac = new byte[addrLen];
        packet.get(clientMac);

        // skip over address padding (16 octets allocated)
        packet.position(packet.position() + (16 - addrLen)
                        + 64    // skip server host name (64 chars)
                        + 128); // skip boot file name (128 chars)

        int dhcpMagicCookie = packet.getInt();

        if (dhcpMagicCookie != DHCP_MAGIC_COOKIE) {
            throw new ParseException(DhcpErrorEvent.DHCP_BAD_MAGIC_COOKIE,
                    "Bad magic cookie 0x%08x, should be 0x%08x",
                    dhcpMagicCookie, DHCP_MAGIC_COOKIE);
        }

        // parse options
        boolean notFinishedOptions = true;

        while ((packet.position() < packet.limit()) && notFinishedOptions) {
            final byte optionType = packet.get(); // cannot underflow because position < limit
            try {
                if (optionType == DHCP_OPTION_END) {
                    notFinishedOptions = false;
                } else if (optionType == DHCP_OPTION_PAD) {
                    // The pad option doesn't have a length field. Nothing to do.
                } else {
                    int optionLen = packet.get() & 0xFF;
                    int expectedLen = 0;

                    switch(optionType) {
                        case DHCP_SUBNET_MASK:
                            netMask = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_ROUTER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                gateways.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_DNS_SERVER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                dnsServers.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_HOST_NAME:
                            expectedLen = optionLen;
                            hostName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MTU:
                            expectedLen = 2;
                            mtu = packet.getShort();
                            break;
                        case DHCP_DOMAIN_NAME:
                            expectedLen = optionLen;
                            domainName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_BROADCAST_ADDRESS:
                            bcAddr = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_REQUESTED_IP:
                            requestedIp = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_LEASE_TIME:
                            leaseTime = Integer.valueOf(packet.getInt());
                            expectedLen = 4;
                            break;
                        case DHCP_MESSAGE_TYPE:
                            dhcpType = packet.get();
                            expectedLen = 1;
                            break;
                        case DHCP_SERVER_IDENTIFIER:
                            serverIdentifier = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_PARAMETER_LIST:
                            expectedParams = new byte[optionLen];
                            packet.get(expectedParams);
                            expectedLen = optionLen;
                            break;
                        case DHCP_MESSAGE:
                            expectedLen = optionLen;
                            message = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MAX_MESSAGE_SIZE:
                            expectedLen = 2;
                            maxMessageSize = Short.valueOf(packet.getShort());
                            break;
                        case DHCP_RENEWAL_TIME:
                            expectedLen = 4;
                            T1 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_REBINDING_TIME:
                            expectedLen = 4;
                            T2 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_VENDOR_CLASS_ID:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorId = readAsciiString(packet, optionLen, true);
                            break;
                        case DHCP_CLIENT_IDENTIFIER: { // Client identifier
                            byte[] id = new byte[optionLen];
                            packet.get(id);
                            expectedLen = optionLen;
                        } break;
                        case DHCP_VENDOR_INFO:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorInfo = readAsciiString(packet, optionLen, true);
                            break;
                        default:
                            // ignore any other parameters
                            for (int i = 0; i < optionLen; i++) {
                                expectedLen++;
                                byte throwaway = packet.get();
                            }
                    }

                    if (expectedLen != optionLen) {
                        final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                                DhcpErrorEvent.DHCP_INVALID_OPTION_LENGTH, optionType);
                        throw new ParseException(errorCode,
                                "Invalid length %d for option %d, expected %d",
                                optionLen, optionType, expectedLen);
                    }
                }
            } catch (BufferUnderflowException e) {
                final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                        DhcpErrorEvent.BUFFER_UNDERFLOW, optionType);
                throw new ParseException(errorCode, "BufferUnderflowException");
            }
        }

        DhcpPacket newPacket;

        switch(dhcpType) {
            case (byte) 0xFF:
                throw new ParseException(DhcpErrorEvent.DHCP_NO_MSG_TYPE,
                        "No DHCP message type option");
            case DHCP_MESSAGE_TYPE_DISCOVER:
                newPacket = new DhcpDiscoverPacket(
                    transactionId, secs, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_OFFER:
                newPacket = new DhcpOfferPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_REQUEST:
                newPacket = new DhcpRequestPacket(
                    transactionId, secs, clientIp, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_DECLINE:
                newPacket = new DhcpDeclinePacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_ACK:
                newPacket = new DhcpAckPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_NAK:
                newPacket = new DhcpNakPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_INFORM:
                newPacket = new DhcpInformPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            default:
                throw new ParseException(DhcpErrorEvent.DHCP_UNKNOWN_MSG_TYPE,
                        "Unimplemented DHCP type %d", dhcpType);
        }

        newPacket.mBroadcastAddress = bcAddr;
        newPacket.mDnsServers = dnsServers;
        newPacket.mDomainName = domainName;
        newPacket.mGateways = gateways;
        newPacket.mHostName = hostName;
        newPacket.mLeaseTime = leaseTime;
        newPacket.mMessage = message;
        newPacket.mMtu = mtu;
        newPacket.mRequestedIp = requestedIp;
        newPacket.mRequestedParams = expectedParams;
        newPacket.mServerIdentifier = serverIdentifier;
        newPacket.mSubnetMask = netMask;
        newPacket.mMaxMessageSize = maxMessageSize;
        newPacket.mT1 = T1;
        newPacket.mT2 = T2;
        newPacket.mVendorId = vendorId;
        newPacket.mVendorInfo = vendorInfo;
        return newPacket;
    }


Number 444:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-decodeFullPacket(ByteBuffer-int)
Corresponding Source:
/**
     * Creates a concrete DhcpPacket from the supplied ByteBuffer.  The
     * buffer may have an L2 encapsulation (which is the full EthernetII
     * format starting with the source-address MAC) or an L3 encapsulation
     * (which starts with the IP header).
     * <br>
     * A subset of the optional parameters are parsed and are stored
     * in object fields.
     */
    public static DhcpPacket decodeFullPacket(ByteBuffer packet, int pktType) throws ParseException
    {
        // bootp parameters
        int transactionId;
        short secs;
        Inet4Address clientIp;
        Inet4Address yourIp;
        Inet4Address nextIp;
        Inet4Address relayIp;
        byte[] clientMac;
        List<Inet4Address> dnsServers = new ArrayList<>();
        List<Inet4Address> gateways = new ArrayList<>();  // aka router
        Inet4Address serverIdentifier = null;
        Inet4Address netMask = null;
        String message = null;
        String vendorId = null;
        String vendorInfo = null;
        byte[] expectedParams = null;
        String hostName = null;
        String domainName = null;
        Inet4Address ipSrc = null;
        Inet4Address ipDst = null;
        Inet4Address bcAddr = null;
        Inet4Address requestedIp = null;

        // The following are all unsigned integers. Internally we store them as signed integers of
        // the same length because that way we're guaranteed that they can't be out of the range of
        // the unsigned field in the packet. Callers wanting to pass in an unsigned value will need
        // to cast it.
        Short mtu = null;
        Short maxMessageSize = null;
        Integer leaseTime = null;
        Integer T1 = null;
        Integer T2 = null;

        // dhcp options
        byte dhcpType = (byte) 0xFF;

        packet.order(ByteOrder.BIG_ENDIAN);

        // check to see if we need to parse L2, IP, and UDP encaps
        if (pktType == ENCAP_L2) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L2) {
                throw new ParseException(DhcpErrorEvent.L2_TOO_SHORT,
                        "L2 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L2);
            }

            byte[] l2dst = new byte[6];
            byte[] l2src = new byte[6];

            packet.get(l2dst);
            packet.get(l2src);

            short l2type = packet.getShort();

            if (l2type != OsConstants.ETH_P_IP) {
                throw new ParseException(DhcpErrorEvent.L2_WRONG_ETH_TYPE,
                        "Unexpected L2 type 0x%04x, expected 0x%04x", l2type, OsConstants.ETH_P_IP);
            }
        }

        if (pktType <= ENCAP_L3) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L3) {
                throw new ParseException(DhcpErrorEvent.L3_TOO_SHORT,
                        "L3 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L3);
            }

            byte ipTypeAndLength = packet.get();
            int ipVersion = (ipTypeAndLength & 0xf0) >> 4;
            if (ipVersion != 4) {
                throw new ParseException(
                        DhcpErrorEvent.L3_NOT_IPV4, "Invalid IP version %d", ipVersion);
            }

            // System.out.println("ipType is " + ipType);
            byte ipDiffServicesField = packet.get();
            short ipTotalLength = packet.getShort();
            short ipIdentification = packet.getShort();
            byte ipFlags = packet.get();
            byte ipFragOffset = packet.get();
            byte ipTTL = packet.get();
            byte ipProto = packet.get();
            short ipChksm = packet.getShort();

            ipSrc = readIpAddress(packet);
            ipDst = readIpAddress(packet);

            if (ipProto != IP_TYPE_UDP) {
                throw new ParseException(
                        DhcpErrorEvent.L4_NOT_UDP, "Protocol not UDP: %d", ipProto);
            }

            // Skip options. This cannot cause us to read beyond the end of the buffer because the
            // IPv4 header cannot be more than (0x0f * 4) = 60 bytes long, and that is less than
            // MIN_PACKET_LENGTH_L3.
            int optionWords = ((ipTypeAndLength & 0x0f) - 5);
            for (int i = 0; i < optionWords; i++) {
                packet.getInt();
            }

            // assume UDP
            short udpSrcPort = packet.getShort();
            short udpDstPort = packet.getShort();
            short udpLen = packet.getShort();
            short udpChkSum = packet.getShort();

            // Only accept packets to or from the well-known client port (expressly permitting
            // packets from ports other than the well-known server port; http://b/24687559), and
            // server-to-server packets, e.g. for relays.
            if (!isPacketToOrFromClient(udpSrcPort, udpDstPort) &&
                !isPacketServerToServer(udpSrcPort, udpDstPort)) {
                // This should almost never happen because we use SO_ATTACH_FILTER on the packet
                // socket to drop packets that don't have the right source ports. However, it's
                // possible that a packet arrives between when the socket is bound and when the
                // filter is set. http://b/26696823 .
                throw new ParseException(DhcpErrorEvent.L4_WRONG_PORT,
                        "Unexpected UDP ports %d->%d", udpSrcPort, udpDstPort);
            }
        }

        // We need to check the length even for ENCAP_L3 because the IPv4 header is variable-length.
        if (pktType > ENCAP_BOOTP || packet.remaining() < MIN_PACKET_LENGTH_BOOTP) {
            throw new ParseException(DhcpErrorEvent.BOOTP_TOO_SHORT,
                        "Invalid type or BOOTP packet too short, %d < %d",
                        packet.remaining(), MIN_PACKET_LENGTH_BOOTP);
        }

        byte type = packet.get();
        byte hwType = packet.get();
        int addrLen = packet.get() & 0xff;
        byte hops = packet.get();
        transactionId = packet.getInt();
        secs = packet.getShort();
        short bootpFlags = packet.getShort();
        boolean broadcast = (bootpFlags & 0x8000) != 0;
        byte[] ipv4addr = new byte[4];

        try {
            packet.get(ipv4addr);
            clientIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            yourIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            nextIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            relayIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
        } catch (UnknownHostException ex) {
            throw new ParseException(DhcpErrorEvent.L3_INVALID_IP,
                    "Invalid IPv4 address: %s", Arrays.toString(ipv4addr));
        }

        // Some DHCP servers have been known to announce invalid client hardware address values such
        // as 0xff. The legacy DHCP client accepted these becuause it does not check the length at
        // all but only checks that the interface MAC address matches the first bytes of the address
        // in the packets. We're a bit stricter: if the length is obviously invalid (i.e., bigger
        // than the size of the field), we fudge it to 6 (Ethernet). http://b/23725795
        // TODO: evaluate whether to make this test more liberal.
        if (addrLen > HWADDR_LEN) {
            addrLen = ETHER_BROADCAST.length;
        }

        clientMac = new byte[addrLen];
        packet.get(clientMac);

        // skip over address padding (16 octets allocated)
        packet.position(packet.position() + (16 - addrLen)
                        + 64    // skip server host name (64 chars)
                        + 128); // skip boot file name (128 chars)

        int dhcpMagicCookie = packet.getInt();

        if (dhcpMagicCookie != DHCP_MAGIC_COOKIE) {
            throw new ParseException(DhcpErrorEvent.DHCP_BAD_MAGIC_COOKIE,
                    "Bad magic cookie 0x%08x, should be 0x%08x",
                    dhcpMagicCookie, DHCP_MAGIC_COOKIE);
        }

        // parse options
        boolean notFinishedOptions = true;

        while ((packet.position() < packet.limit()) && notFinishedOptions) {
            final byte optionType = packet.get(); // cannot underflow because position < limit
            try {
                if (optionType == DHCP_OPTION_END) {
                    notFinishedOptions = false;
                } else if (optionType == DHCP_OPTION_PAD) {
                    // The pad option doesn't have a length field. Nothing to do.
                } else {
                    int optionLen = packet.get() & 0xFF;
                    int expectedLen = 0;

                    switch(optionType) {
                        case DHCP_SUBNET_MASK:
                            netMask = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_ROUTER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                gateways.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_DNS_SERVER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                dnsServers.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_HOST_NAME:
                            expectedLen = optionLen;
                            hostName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MTU:
                            expectedLen = 2;
                            mtu = packet.getShort();
                            break;
                        case DHCP_DOMAIN_NAME:
                            expectedLen = optionLen;
                            domainName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_BROADCAST_ADDRESS:
                            bcAddr = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_REQUESTED_IP:
                            requestedIp = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_LEASE_TIME:
                            leaseTime = Integer.valueOf(packet.getInt());
                            expectedLen = 4;
                            break;
                        case DHCP_MESSAGE_TYPE:
                            dhcpType = packet.get();
                            expectedLen = 1;
                            break;
                        case DHCP_SERVER_IDENTIFIER:
                            serverIdentifier = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_PARAMETER_LIST:
                            expectedParams = new byte[optionLen];
                            packet.get(expectedParams);
                            expectedLen = optionLen;
                            break;
                        case DHCP_MESSAGE:
                            expectedLen = optionLen;
                            message = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MAX_MESSAGE_SIZE:
                            expectedLen = 2;
                            maxMessageSize = Short.valueOf(packet.getShort());
                            break;
                        case DHCP_RENEWAL_TIME:
                            expectedLen = 4;
                            T1 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_REBINDING_TIME:
                            expectedLen = 4;
                            T2 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_VENDOR_CLASS_ID:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorId = readAsciiString(packet, optionLen, true);
                            break;
                        case DHCP_CLIENT_IDENTIFIER: { // Client identifier
                            byte[] id = new byte[optionLen];
                            packet.get(id);
                            expectedLen = optionLen;
                        } break;
                        case DHCP_VENDOR_INFO:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorInfo = readAsciiString(packet, optionLen, true);
                            break;
                        default:
                            // ignore any other parameters
                            for (int i = 0; i < optionLen; i++) {
                                expectedLen++;
                                byte throwaway = packet.get();
                            }
                    }

                    if (expectedLen != optionLen) {
                        final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                                DhcpErrorEvent.DHCP_INVALID_OPTION_LENGTH, optionType);
                        throw new ParseException(errorCode,
                                "Invalid length %d for option %d, expected %d",
                                optionLen, optionType, expectedLen);
                    }
                }
            } catch (BufferUnderflowException e) {
                final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                        DhcpErrorEvent.BUFFER_UNDERFLOW, optionType);
                throw new ParseException(errorCode, "BufferUnderflowException");
            }
        }

        DhcpPacket newPacket;

        switch(dhcpType) {
            case (byte) 0xFF:
                throw new ParseException(DhcpErrorEvent.DHCP_NO_MSG_TYPE,
                        "No DHCP message type option");
            case DHCP_MESSAGE_TYPE_DISCOVER:
                newPacket = new DhcpDiscoverPacket(
                    transactionId, secs, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_OFFER:
                newPacket = new DhcpOfferPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_REQUEST:
                newPacket = new DhcpRequestPacket(
                    transactionId, secs, clientIp, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_DECLINE:
                newPacket = new DhcpDeclinePacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_ACK:
                newPacket = new DhcpAckPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_NAK:
                newPacket = new DhcpNakPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_INFORM:
                newPacket = new DhcpInformPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            default:
                throw new ParseException(DhcpErrorEvent.DHCP_UNKNOWN_MSG_TYPE,
                        "Unimplemented DHCP type %d", dhcpType);
        }

        newPacket.mBroadcastAddress = bcAddr;
        newPacket.mDnsServers = dnsServers;
        newPacket.mDomainName = domainName;
        newPacket.mGateways = gateways;
        newPacket.mHostName = hostName;
        newPacket.mLeaseTime = leaseTime;
        newPacket.mMessage = message;
        newPacket.mMtu = mtu;
        newPacket.mRequestedIp = requestedIp;
        newPacket.mRequestedParams = expectedParams;
        newPacket.mServerIdentifier = serverIdentifier;
        newPacket.mSubnetMask = netMask;
        newPacket.mMaxMessageSize = maxMessageSize;
        newPacket.mT1 = T1;
        newPacket.mT2 = T2;
        newPacket.mVendorId = vendorId;
        newPacket.mVendorInfo = vendorInfo;
        return newPacket;
    }


Number 445:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-decodeFullPacket(ByteBuffer-int)
Corresponding Source:
/**
     * Creates a concrete DhcpPacket from the supplied ByteBuffer.  The
     * buffer may have an L2 encapsulation (which is the full EthernetII
     * format starting with the source-address MAC) or an L3 encapsulation
     * (which starts with the IP header).
     * <br>
     * A subset of the optional parameters are parsed and are stored
     * in object fields.
     */
    public static DhcpPacket decodeFullPacket(ByteBuffer packet, int pktType) throws ParseException
    {
        // bootp parameters
        int transactionId;
        short secs;
        Inet4Address clientIp;
        Inet4Address yourIp;
        Inet4Address nextIp;
        Inet4Address relayIp;
        byte[] clientMac;
        List<Inet4Address> dnsServers = new ArrayList<>();
        List<Inet4Address> gateways = new ArrayList<>();  // aka router
        Inet4Address serverIdentifier = null;
        Inet4Address netMask = null;
        String message = null;
        String vendorId = null;
        String vendorInfo = null;
        byte[] expectedParams = null;
        String hostName = null;
        String domainName = null;
        Inet4Address ipSrc = null;
        Inet4Address ipDst = null;
        Inet4Address bcAddr = null;
        Inet4Address requestedIp = null;

        // The following are all unsigned integers. Internally we store them as signed integers of
        // the same length because that way we're guaranteed that they can't be out of the range of
        // the unsigned field in the packet. Callers wanting to pass in an unsigned value will need
        // to cast it.
        Short mtu = null;
        Short maxMessageSize = null;
        Integer leaseTime = null;
        Integer T1 = null;
        Integer T2 = null;

        // dhcp options
        byte dhcpType = (byte) 0xFF;

        packet.order(ByteOrder.BIG_ENDIAN);

        // check to see if we need to parse L2, IP, and UDP encaps
        if (pktType == ENCAP_L2) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L2) {
                throw new ParseException(DhcpErrorEvent.L2_TOO_SHORT,
                        "L2 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L2);
            }

            byte[] l2dst = new byte[6];
            byte[] l2src = new byte[6];

            packet.get(l2dst);
            packet.get(l2src);

            short l2type = packet.getShort();

            if (l2type != OsConstants.ETH_P_IP) {
                throw new ParseException(DhcpErrorEvent.L2_WRONG_ETH_TYPE,
                        "Unexpected L2 type 0x%04x, expected 0x%04x", l2type, OsConstants.ETH_P_IP);
            }
        }

        if (pktType <= ENCAP_L3) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L3) {
                throw new ParseException(DhcpErrorEvent.L3_TOO_SHORT,
                        "L3 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L3);
            }

            byte ipTypeAndLength = packet.get();
            int ipVersion = (ipTypeAndLength & 0xf0) >> 4;
            if (ipVersion != 4) {
                throw new ParseException(
                        DhcpErrorEvent.L3_NOT_IPV4, "Invalid IP version %d", ipVersion);
            }

            // System.out.println("ipType is " + ipType);
            byte ipDiffServicesField = packet.get();
            short ipTotalLength = packet.getShort();
            short ipIdentification = packet.getShort();
            byte ipFlags = packet.get();
            byte ipFragOffset = packet.get();
            byte ipTTL = packet.get();
            byte ipProto = packet.get();
            short ipChksm = packet.getShort();

            ipSrc = readIpAddress(packet);
            ipDst = readIpAddress(packet);

            if (ipProto != IP_TYPE_UDP) {
                throw new ParseException(
                        DhcpErrorEvent.L4_NOT_UDP, "Protocol not UDP: %d", ipProto);
            }

            // Skip options. This cannot cause us to read beyond the end of the buffer because the
            // IPv4 header cannot be more than (0x0f * 4) = 60 bytes long, and that is less than
            // MIN_PACKET_LENGTH_L3.
            int optionWords = ((ipTypeAndLength & 0x0f) - 5);
            for (int i = 0; i < optionWords; i++) {
                packet.getInt();
            }

            // assume UDP
            short udpSrcPort = packet.getShort();
            short udpDstPort = packet.getShort();
            short udpLen = packet.getShort();
            short udpChkSum = packet.getShort();

            // Only accept packets to or from the well-known client port (expressly permitting
            // packets from ports other than the well-known server port; http://b/24687559), and
            // server-to-server packets, e.g. for relays.
            if (!isPacketToOrFromClient(udpSrcPort, udpDstPort) &&
                !isPacketServerToServer(udpSrcPort, udpDstPort)) {
                // This should almost never happen because we use SO_ATTACH_FILTER on the packet
                // socket to drop packets that don't have the right source ports. However, it's
                // possible that a packet arrives between when the socket is bound and when the
                // filter is set. http://b/26696823 .
                throw new ParseException(DhcpErrorEvent.L4_WRONG_PORT,
                        "Unexpected UDP ports %d->%d", udpSrcPort, udpDstPort);
            }
        }

        // We need to check the length even for ENCAP_L3 because the IPv4 header is variable-length.
        if (pktType > ENCAP_BOOTP || packet.remaining() < MIN_PACKET_LENGTH_BOOTP) {
            throw new ParseException(DhcpErrorEvent.BOOTP_TOO_SHORT,
                        "Invalid type or BOOTP packet too short, %d < %d",
                        packet.remaining(), MIN_PACKET_LENGTH_BOOTP);
        }

        byte type = packet.get();
        byte hwType = packet.get();
        int addrLen = packet.get() & 0xff;
        byte hops = packet.get();
        transactionId = packet.getInt();
        secs = packet.getShort();
        short bootpFlags = packet.getShort();
        boolean broadcast = (bootpFlags & 0x8000) != 0;
        byte[] ipv4addr = new byte[4];

        try {
            packet.get(ipv4addr);
            clientIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            yourIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            nextIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            relayIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
        } catch (UnknownHostException ex) {
            throw new ParseException(DhcpErrorEvent.L3_INVALID_IP,
                    "Invalid IPv4 address: %s", Arrays.toString(ipv4addr));
        }

        // Some DHCP servers have been known to announce invalid client hardware address values such
        // as 0xff. The legacy DHCP client accepted these becuause it does not check the length at
        // all but only checks that the interface MAC address matches the first bytes of the address
        // in the packets. We're a bit stricter: if the length is obviously invalid (i.e., bigger
        // than the size of the field), we fudge it to 6 (Ethernet). http://b/23725795
        // TODO: evaluate whether to make this test more liberal.
        if (addrLen > HWADDR_LEN) {
            addrLen = ETHER_BROADCAST.length;
        }

        clientMac = new byte[addrLen];
        packet.get(clientMac);

        // skip over address padding (16 octets allocated)
        packet.position(packet.position() + (16 - addrLen)
                        + 64    // skip server host name (64 chars)
                        + 128); // skip boot file name (128 chars)

        int dhcpMagicCookie = packet.getInt();

        if (dhcpMagicCookie != DHCP_MAGIC_COOKIE) {
            throw new ParseException(DhcpErrorEvent.DHCP_BAD_MAGIC_COOKIE,
                    "Bad magic cookie 0x%08x, should be 0x%08x",
                    dhcpMagicCookie, DHCP_MAGIC_COOKIE);
        }

        // parse options
        boolean notFinishedOptions = true;

        while ((packet.position() < packet.limit()) && notFinishedOptions) {
            final byte optionType = packet.get(); // cannot underflow because position < limit
            try {
                if (optionType == DHCP_OPTION_END) {
                    notFinishedOptions = false;
                } else if (optionType == DHCP_OPTION_PAD) {
                    // The pad option doesn't have a length field. Nothing to do.
                } else {
                    int optionLen = packet.get() & 0xFF;
                    int expectedLen = 0;

                    switch(optionType) {
                        case DHCP_SUBNET_MASK:
                            netMask = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_ROUTER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                gateways.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_DNS_SERVER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                dnsServers.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_HOST_NAME:
                            expectedLen = optionLen;
                            hostName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MTU:
                            expectedLen = 2;
                            mtu = packet.getShort();
                            break;
                        case DHCP_DOMAIN_NAME:
                            expectedLen = optionLen;
                            domainName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_BROADCAST_ADDRESS:
                            bcAddr = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_REQUESTED_IP:
                            requestedIp = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_LEASE_TIME:
                            leaseTime = Integer.valueOf(packet.getInt());
                            expectedLen = 4;
                            break;
                        case DHCP_MESSAGE_TYPE:
                            dhcpType = packet.get();
                            expectedLen = 1;
                            break;
                        case DHCP_SERVER_IDENTIFIER:
                            serverIdentifier = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_PARAMETER_LIST:
                            expectedParams = new byte[optionLen];
                            packet.get(expectedParams);
                            expectedLen = optionLen;
                            break;
                        case DHCP_MESSAGE:
                            expectedLen = optionLen;
                            message = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MAX_MESSAGE_SIZE:
                            expectedLen = 2;
                            maxMessageSize = Short.valueOf(packet.getShort());
                            break;
                        case DHCP_RENEWAL_TIME:
                            expectedLen = 4;
                            T1 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_REBINDING_TIME:
                            expectedLen = 4;
                            T2 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_VENDOR_CLASS_ID:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorId = readAsciiString(packet, optionLen, true);
                            break;
                        case DHCP_CLIENT_IDENTIFIER: { // Client identifier
                            byte[] id = new byte[optionLen];
                            packet.get(id);
                            expectedLen = optionLen;
                        } break;
                        case DHCP_VENDOR_INFO:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorInfo = readAsciiString(packet, optionLen, true);
                            break;
                        default:
                            // ignore any other parameters
                            for (int i = 0; i < optionLen; i++) {
                                expectedLen++;
                                byte throwaway = packet.get();
                            }
                    }

                    if (expectedLen != optionLen) {
                        final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                                DhcpErrorEvent.DHCP_INVALID_OPTION_LENGTH, optionType);
                        throw new ParseException(errorCode,
                                "Invalid length %d for option %d, expected %d",
                                optionLen, optionType, expectedLen);
                    }
                }
            } catch (BufferUnderflowException e) {
                final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                        DhcpErrorEvent.BUFFER_UNDERFLOW, optionType);
                throw new ParseException(errorCode, "BufferUnderflowException");
            }
        }

        DhcpPacket newPacket;

        switch(dhcpType) {
            case (byte) 0xFF:
                throw new ParseException(DhcpErrorEvent.DHCP_NO_MSG_TYPE,
                        "No DHCP message type option");
            case DHCP_MESSAGE_TYPE_DISCOVER:
                newPacket = new DhcpDiscoverPacket(
                    transactionId, secs, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_OFFER:
                newPacket = new DhcpOfferPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_REQUEST:
                newPacket = new DhcpRequestPacket(
                    transactionId, secs, clientIp, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_DECLINE:
                newPacket = new DhcpDeclinePacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_ACK:
                newPacket = new DhcpAckPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_NAK:
                newPacket = new DhcpNakPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_INFORM:
                newPacket = new DhcpInformPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            default:
                throw new ParseException(DhcpErrorEvent.DHCP_UNKNOWN_MSG_TYPE,
                        "Unimplemented DHCP type %d", dhcpType);
        }

        newPacket.mBroadcastAddress = bcAddr;
        newPacket.mDnsServers = dnsServers;
        newPacket.mDomainName = domainName;
        newPacket.mGateways = gateways;
        newPacket.mHostName = hostName;
        newPacket.mLeaseTime = leaseTime;
        newPacket.mMessage = message;
        newPacket.mMtu = mtu;
        newPacket.mRequestedIp = requestedIp;
        newPacket.mRequestedParams = expectedParams;
        newPacket.mServerIdentifier = serverIdentifier;
        newPacket.mSubnetMask = netMask;
        newPacket.mMaxMessageSize = maxMessageSize;
        newPacket.mT1 = T1;
        newPacket.mT2 = T2;
        newPacket.mVendorId = vendorId;
        newPacket.mVendorInfo = vendorInfo;
        return newPacket;
    }


Number 446:
API Relative Path:
src.android.net.dhcp.DhcpPacket.java-decodeFullPacket(ByteBuffer-int)
Corresponding Source:
/**
     * Creates a concrete DhcpPacket from the supplied ByteBuffer.  The
     * buffer may have an L2 encapsulation (which is the full EthernetII
     * format starting with the source-address MAC) or an L3 encapsulation
     * (which starts with the IP header).
     * <br>
     * A subset of the optional parameters are parsed and are stored
     * in object fields.
     */
    public static DhcpPacket decodeFullPacket(ByteBuffer packet, int pktType) throws ParseException
    {
        // bootp parameters
        int transactionId;
        short secs;
        Inet4Address clientIp;
        Inet4Address yourIp;
        Inet4Address nextIp;
        Inet4Address relayIp;
        byte[] clientMac;
        List<Inet4Address> dnsServers = new ArrayList<>();
        List<Inet4Address> gateways = new ArrayList<>();  // aka router
        Inet4Address serverIdentifier = null;
        Inet4Address netMask = null;
        String message = null;
        String vendorId = null;
        String vendorInfo = null;
        byte[] expectedParams = null;
        String hostName = null;
        String domainName = null;
        Inet4Address ipSrc = null;
        Inet4Address ipDst = null;
        Inet4Address bcAddr = null;
        Inet4Address requestedIp = null;

        // The following are all unsigned integers. Internally we store them as signed integers of
        // the same length because that way we're guaranteed that they can't be out of the range of
        // the unsigned field in the packet. Callers wanting to pass in an unsigned value will need
        // to cast it.
        Short mtu = null;
        Short maxMessageSize = null;
        Integer leaseTime = null;
        Integer T1 = null;
        Integer T2 = null;

        // dhcp options
        byte dhcpType = (byte) 0xFF;

        packet.order(ByteOrder.BIG_ENDIAN);

        // check to see if we need to parse L2, IP, and UDP encaps
        if (pktType == ENCAP_L2) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L2) {
                throw new ParseException(DhcpErrorEvent.L2_TOO_SHORT,
                        "L2 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L2);
            }

            byte[] l2dst = new byte[6];
            byte[] l2src = new byte[6];

            packet.get(l2dst);
            packet.get(l2src);

            short l2type = packet.getShort();

            if (l2type != OsConstants.ETH_P_IP) {
                throw new ParseException(DhcpErrorEvent.L2_WRONG_ETH_TYPE,
                        "Unexpected L2 type 0x%04x, expected 0x%04x", l2type, OsConstants.ETH_P_IP);
            }
        }

        if (pktType <= ENCAP_L3) {
            if (packet.remaining() < MIN_PACKET_LENGTH_L3) {
                throw new ParseException(DhcpErrorEvent.L3_TOO_SHORT,
                        "L3 packet too short, %d < %d", packet.remaining(), MIN_PACKET_LENGTH_L3);
            }

            byte ipTypeAndLength = packet.get();
            int ipVersion = (ipTypeAndLength & 0xf0) >> 4;
            if (ipVersion != 4) {
                throw new ParseException(
                        DhcpErrorEvent.L3_NOT_IPV4, "Invalid IP version %d", ipVersion);
            }

            // System.out.println("ipType is " + ipType);
            byte ipDiffServicesField = packet.get();
            short ipTotalLength = packet.getShort();
            short ipIdentification = packet.getShort();
            byte ipFlags = packet.get();
            byte ipFragOffset = packet.get();
            byte ipTTL = packet.get();
            byte ipProto = packet.get();
            short ipChksm = packet.getShort();

            ipSrc = readIpAddress(packet);
            ipDst = readIpAddress(packet);

            if (ipProto != IP_TYPE_UDP) {
                throw new ParseException(
                        DhcpErrorEvent.L4_NOT_UDP, "Protocol not UDP: %d", ipProto);
            }

            // Skip options. This cannot cause us to read beyond the end of the buffer because the
            // IPv4 header cannot be more than (0x0f * 4) = 60 bytes long, and that is less than
            // MIN_PACKET_LENGTH_L3.
            int optionWords = ((ipTypeAndLength & 0x0f) - 5);
            for (int i = 0; i < optionWords; i++) {
                packet.getInt();
            }

            // assume UDP
            short udpSrcPort = packet.getShort();
            short udpDstPort = packet.getShort();
            short udpLen = packet.getShort();
            short udpChkSum = packet.getShort();

            // Only accept packets to or from the well-known client port (expressly permitting
            // packets from ports other than the well-known server port; http://b/24687559), and
            // server-to-server packets, e.g. for relays.
            if (!isPacketToOrFromClient(udpSrcPort, udpDstPort) &&
                !isPacketServerToServer(udpSrcPort, udpDstPort)) {
                // This should almost never happen because we use SO_ATTACH_FILTER on the packet
                // socket to drop packets that don't have the right source ports. However, it's
                // possible that a packet arrives between when the socket is bound and when the
                // filter is set. http://b/26696823 .
                throw new ParseException(DhcpErrorEvent.L4_WRONG_PORT,
                        "Unexpected UDP ports %d->%d", udpSrcPort, udpDstPort);
            }
        }

        // We need to check the length even for ENCAP_L3 because the IPv4 header is variable-length.
        if (pktType > ENCAP_BOOTP || packet.remaining() < MIN_PACKET_LENGTH_BOOTP) {
            throw new ParseException(DhcpErrorEvent.BOOTP_TOO_SHORT,
                        "Invalid type or BOOTP packet too short, %d < %d",
                        packet.remaining(), MIN_PACKET_LENGTH_BOOTP);
        }

        byte type = packet.get();
        byte hwType = packet.get();
        int addrLen = packet.get() & 0xff;
        byte hops = packet.get();
        transactionId = packet.getInt();
        secs = packet.getShort();
        short bootpFlags = packet.getShort();
        boolean broadcast = (bootpFlags & 0x8000) != 0;
        byte[] ipv4addr = new byte[4];

        try {
            packet.get(ipv4addr);
            clientIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            yourIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            nextIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
            packet.get(ipv4addr);
            relayIp = (Inet4Address) Inet4Address.getByAddress(ipv4addr);
        } catch (UnknownHostException ex) {
            throw new ParseException(DhcpErrorEvent.L3_INVALID_IP,
                    "Invalid IPv4 address: %s", Arrays.toString(ipv4addr));
        }

        // Some DHCP servers have been known to announce invalid client hardware address values such
        // as 0xff. The legacy DHCP client accepted these becuause it does not check the length at
        // all but only checks that the interface MAC address matches the first bytes of the address
        // in the packets. We're a bit stricter: if the length is obviously invalid (i.e., bigger
        // than the size of the field), we fudge it to 6 (Ethernet). http://b/23725795
        // TODO: evaluate whether to make this test more liberal.
        if (addrLen > HWADDR_LEN) {
            addrLen = ETHER_BROADCAST.length;
        }

        clientMac = new byte[addrLen];
        packet.get(clientMac);

        // skip over address padding (16 octets allocated)
        packet.position(packet.position() + (16 - addrLen)
                        + 64    // skip server host name (64 chars)
                        + 128); // skip boot file name (128 chars)

        int dhcpMagicCookie = packet.getInt();

        if (dhcpMagicCookie != DHCP_MAGIC_COOKIE) {
            throw new ParseException(DhcpErrorEvent.DHCP_BAD_MAGIC_COOKIE,
                    "Bad magic cookie 0x%08x, should be 0x%08x",
                    dhcpMagicCookie, DHCP_MAGIC_COOKIE);
        }

        // parse options
        boolean notFinishedOptions = true;

        while ((packet.position() < packet.limit()) && notFinishedOptions) {
            final byte optionType = packet.get(); // cannot underflow because position < limit
            try {
                if (optionType == DHCP_OPTION_END) {
                    notFinishedOptions = false;
                } else if (optionType == DHCP_OPTION_PAD) {
                    // The pad option doesn't have a length field. Nothing to do.
                } else {
                    int optionLen = packet.get() & 0xFF;
                    int expectedLen = 0;

                    switch(optionType) {
                        case DHCP_SUBNET_MASK:
                            netMask = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_ROUTER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                gateways.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_DNS_SERVER:
                            for (expectedLen = 0; expectedLen < optionLen; expectedLen += 4) {
                                dnsServers.add(readIpAddress(packet));
                            }
                            break;
                        case DHCP_HOST_NAME:
                            expectedLen = optionLen;
                            hostName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MTU:
                            expectedLen = 2;
                            mtu = packet.getShort();
                            break;
                        case DHCP_DOMAIN_NAME:
                            expectedLen = optionLen;
                            domainName = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_BROADCAST_ADDRESS:
                            bcAddr = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_REQUESTED_IP:
                            requestedIp = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_LEASE_TIME:
                            leaseTime = Integer.valueOf(packet.getInt());
                            expectedLen = 4;
                            break;
                        case DHCP_MESSAGE_TYPE:
                            dhcpType = packet.get();
                            expectedLen = 1;
                            break;
                        case DHCP_SERVER_IDENTIFIER:
                            serverIdentifier = readIpAddress(packet);
                            expectedLen = 4;
                            break;
                        case DHCP_PARAMETER_LIST:
                            expectedParams = new byte[optionLen];
                            packet.get(expectedParams);
                            expectedLen = optionLen;
                            break;
                        case DHCP_MESSAGE:
                            expectedLen = optionLen;
                            message = readAsciiString(packet, optionLen, false);
                            break;
                        case DHCP_MAX_MESSAGE_SIZE:
                            expectedLen = 2;
                            maxMessageSize = Short.valueOf(packet.getShort());
                            break;
                        case DHCP_RENEWAL_TIME:
                            expectedLen = 4;
                            T1 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_REBINDING_TIME:
                            expectedLen = 4;
                            T2 = Integer.valueOf(packet.getInt());
                            break;
                        case DHCP_VENDOR_CLASS_ID:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorId = readAsciiString(packet, optionLen, true);
                            break;
                        case DHCP_CLIENT_IDENTIFIER: { // Client identifier
                            byte[] id = new byte[optionLen];
                            packet.get(id);
                            expectedLen = optionLen;
                        } break;
                        case DHCP_VENDOR_INFO:
                            expectedLen = optionLen;
                            // Embedded nulls are safe as this does not get passed to netd.
                            vendorInfo = readAsciiString(packet, optionLen, true);
                            break;
                        default:
                            // ignore any other parameters
                            for (int i = 0; i < optionLen; i++) {
                                expectedLen++;
                                byte throwaway = packet.get();
                            }
                    }

                    if (expectedLen != optionLen) {
                        final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                                DhcpErrorEvent.DHCP_INVALID_OPTION_LENGTH, optionType);
                        throw new ParseException(errorCode,
                                "Invalid length %d for option %d, expected %d",
                                optionLen, optionType, expectedLen);
                    }
                }
            } catch (BufferUnderflowException e) {
                final int errorCode = DhcpErrorEvent.errorCodeWithOption(
                        DhcpErrorEvent.BUFFER_UNDERFLOW, optionType);
                throw new ParseException(errorCode, "BufferUnderflowException");
            }
        }

        DhcpPacket newPacket;

        switch(dhcpType) {
            case (byte) 0xFF:
                throw new ParseException(DhcpErrorEvent.DHCP_NO_MSG_TYPE,
                        "No DHCP message type option");
            case DHCP_MESSAGE_TYPE_DISCOVER:
                newPacket = new DhcpDiscoverPacket(
                    transactionId, secs, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_OFFER:
                newPacket = new DhcpOfferPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_REQUEST:
                newPacket = new DhcpRequestPacket(
                    transactionId, secs, clientIp, clientMac, broadcast);
                break;
            case DHCP_MESSAGE_TYPE_DECLINE:
                newPacket = new DhcpDeclinePacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_ACK:
                newPacket = new DhcpAckPacket(
                    transactionId, secs, broadcast, ipSrc, clientIp, yourIp, clientMac);
                break;
            case DHCP_MESSAGE_TYPE_NAK:
                newPacket = new DhcpNakPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            case DHCP_MESSAGE_TYPE_INFORM:
                newPacket = new DhcpInformPacket(
                    transactionId, secs, clientIp, yourIp, nextIp, relayIp,
                    clientMac);
                break;
            default:
                throw new ParseException(DhcpErrorEvent.DHCP_UNKNOWN_MSG_TYPE,
                        "Unimplemented DHCP type %d", dhcpType);
        }

        newPacket.mBroadcastAddress = bcAddr;
        newPacket.mDnsServers = dnsServers;
        newPacket.mDomainName = domainName;
        newPacket.mGateways = gateways;
        newPacket.mHostName = hostName;
        newPacket.mLeaseTime = leaseTime;
        newPacket.mMessage = message;
        newPacket.mMtu = mtu;
        newPacket.mRequestedIp = requestedIp;
        newPacket.mRequestedParams = expectedParams;
        newPacket.mServerIdentifier = serverIdentifier;
        newPacket.mSubnetMask = netMask;
        newPacket.mMaxMessageSize = maxMessageSize;
        newPacket.mT1 = T1;
        newPacket.mT2 = T2;
        newPacket.mVendorId = vendorId;
        newPacket.mVendorInfo = vendorInfo;
        return newPacket;
    }


Number 447:
API Relative Path:
src.android.net.DhcpInfo.java-DhcpInfo(DhcpInfo)
Corresponding Source:
/** copy constructor {@hide} */
    public DhcpInfo(DhcpInfo source) {
        if (source != null) {
            ipAddress = source.ipAddress;
            gateway = source.gateway;
            netmask = source.netmask;
            dns1 = source.dns1;
            dns2 = source.dns2;
            serverAddress = source.serverAddress;
            leaseDuration = source.leaseDuration;
        }
    }


Number 448:
API Relative Path:
src.android.net.http.SslCertificate.java-restoreState(Bundle)
Corresponding Source:
/**
     * Restores the certificate stored in the bundle
     * @param bundle The bundle with the certificate state stored in it
     * @return The SSL certificate stored in the bundle or null if fails
     */
    public static SslCertificate restoreState(Bundle bundle) {
        if (bundle == null) {
            return null;
        }
        X509Certificate x509Certificate;
        byte[] bytes = bundle.getByteArray(X509_CERTIFICATE);
        if (bytes == null) {
            x509Certificate = null;
        } else {
            try {
                CertificateFactory certFactory = CertificateFactory.getInstance("X.509");
                Certificate cert = certFactory.generateCertificate(new ByteArrayInputStream(bytes));
                x509Certificate = (X509Certificate) cert;
            } catch (CertificateException e) {
                x509Certificate = null;
            }
        }
        return new SslCertificate(bundle.getString(ISSUED_TO),
                                  bundle.getString(ISSUED_BY),
                                  parseDate(bundle.getString(VALID_NOT_BEFORE)),
                                  parseDate(bundle.getString(VALID_NOT_AFTER)),
                                  x509Certificate);
    }


Number 449:
API Relative Path:
src.android.net.http.SslCertificate.java-saveState(SslCertificate)
Corresponding Source:
/**
     * Saves the certificate state to a bundle
     * @param certificate The SSL certificate to store
     * @return A bundle with the certificate stored in it or null if fails
     */
    public static Bundle saveState(SslCertificate certificate) {
        if (certificate == null) {
            return null;
        }
        Bundle bundle = new Bundle();
        bundle.putString(ISSUED_TO, certificate.getIssuedTo().getDName());
        bundle.putString(ISSUED_BY, certificate.getIssuedBy().getDName());
        bundle.putString(VALID_NOT_BEFORE, certificate.getValidNotBefore());
        bundle.putString(VALID_NOT_AFTER, certificate.getValidNotAfter());
        X509Certificate x509Certificate = certificate.mX509Certificate;
        if (x509Certificate != null) {
            try {
                bundle.putByteArray(X509_CERTIFICATE, x509Certificate.getEncoded());
            } catch (CertificateEncodingException ignored) {
            }
        }
        return bundle;
    }


Number 450:
API Relative Path:
src.android.net.LinkProperties.java-addRoute(RouteInfo)
Corresponding Source:
/**
     * Adds a {@link RouteInfo} to this {@code LinkProperties}, if not present. If the
     * {@link RouteInfo} had an interface name set and that differs from the interface set for this
     * {@code LinkProperties} an {@link IllegalArgumentException} will be thrown.  The proper
     * course is to add either un-named or properly named {@link RouteInfo}.
     *
     * @param route A {@link RouteInfo} to add to this object.
     * @return {@code false} if the route was already present, {@code true} if it was added.
     *
     * @hide
     */
    public boolean addRoute(RouteInfo route) {
        if (route != null) {
            String routeIface = route.getInterface();
            if (routeIface != null && !routeIface.equals(mIfaceName)) {
                throw new IllegalArgumentException(
                   "Route added with non-matching interface: " + routeIface +
                   " vs. " + mIfaceName);
            }
            route = routeWithInterface(route);
            if (!mRoutes.contains(route)) {
                mRoutes.add(route);
                return true;
            }
        }
        return false;
    }


Number 451:
API Relative Path:
src.android.net.LinkProperties.java-LinkProperties(LinkProperties)
Corresponding Source:
/**
     * @hide
     */
    public LinkProperties(LinkProperties source) {
        if (source != null) {
            mIfaceName = source.getInterfaceName();
            for (LinkAddress l : source.getLinkAddresses()) mLinkAddresses.add(l);
            for (InetAddress i : source.getDnsServers()) mDnses.add(i);
            mDomains = source.getDomains();
            for (RouteInfo r : source.getRoutes()) mRoutes.add(r);
            mHttpProxy = (source.getHttpProxy() == null)  ?
                    null : new ProxyInfo(source.getHttpProxy());
            for (LinkProperties l: source.mStackedLinks.values()) {
                addStackedLink(l);
            }
            setMtu(source.getMtu());
            mTcpBufferSizes = source.mTcpBufferSizes;
        }
    }


Number 452:
API Relative Path:
src.android.net.MailTo.java-parse(String)
Corresponding Source:
/**
     * Parse and decode a mailto scheme string. This parser implements
     * RFC 2368. The returned object can be queried for the parsed parameters.
     * @param url String containing a mailto URL
     * @return MailTo object
     * @exception ParseException if the scheme is not a mailto URL
     */
    public static MailTo parse(String url) throws ParseException {
        if (url == null) {
            throw new NullPointerException();
        }
        if (!isMailTo(url)) {
             throw new ParseException("Not a mailto scheme");
        }
        // Strip the scheme as the Uri parser can't cope with it.
        String noScheme = url.substring(MAILTO_SCHEME.length());
        Uri email = Uri.parse(noScheme);
        MailTo m = new MailTo();
        
        // Parse out the query parameters
        String query = email.getQuery();
        if (query != null ) {
            String[] queries = query.split("&");
            for (String q : queries) {
                String[] nameval = q.split("=");
                if (nameval.length == 0) {
                    continue;
                }
                // insert the headers with the name in lowercase so that
                // we can easily find common headers
                m.mHeaders.put(Uri.decode(nameval[0]).toLowerCase(Locale.ROOT),
                        nameval.length > 1 ? Uri.decode(nameval[1]) : null);
            }
        }
        
        // Address can be specified in both the headers and just after the
        // mailto line. Join the two together.
        String address = email.getPath();
        if (address != null) {
            String addr = m.getTo();
            if (addr != null) {
                address += ", " + addr;
            }
            m.mHeaders.put(TO, address);
        }
        
        return m;
    }


Number 453:
API Relative Path:
src.android.net.NetworkAgent.java-sendNetworkScore(int)
Corresponding Source:
/**
     * Called by the bearer code when it has a new score for this network.
     */
    public void sendNetworkScore(int score) {
        if (score < 0) {
            throw new IllegalArgumentException("Score must be >= 0");
        }
        queueOrSendMessage(EVENT_NETWORK_SCORE_CHANGED, new Integer(score));
    }


Number 454:
API Relative Path:
src.android.net.NetworkCapabilities.java-addCapability(int)
Corresponding Source:
/**
     * Adds the given capability to this {@code NetworkCapability} instance.
     * Multiple capabilities may be applied sequentially.  Note that when searching
     * for a network to satisfy a request, all capabilities requested must be satisfied.
     *
     * @param capability the {@code NetworkCapabilities.NET_CAPABILITY_*} to be added.
     * @return This NetworkCapabilities instance, to facilitate chaining.
     * @hide
     */
    public NetworkCapabilities addCapability(int capability) {
        if (capability < MIN_NET_CAPABILITY || capability > MAX_NET_CAPABILITY) {
            throw new IllegalArgumentException("NetworkCapability out of range");
        }
        mNetworkCapabilities |= 1 << capability;
        return this;
    }


Number 455:
API Relative Path:
src.android.net.NetworkCapabilities.java-addTransportType(int)
Corresponding Source:
/**
     * Adds the given transport type to this {@code NetworkCapability} instance.
     * Multiple transports may be applied sequentially.  Note that when searching
     * for a network to satisfy a request, any listed in the request will satisfy the request.
     * For example {@code TRANSPORT_WIFI} and {@code TRANSPORT_ETHERNET} added to a
     * {@code NetworkCapabilities} would cause either a Wi-Fi network or an Ethernet network
     * to be selected.  This is logically different than
     * {@code NetworkCapabilities.NET_CAPABILITY_*} listed above.
     *
     * @param transportType the {@code NetworkCapabilities.TRANSPORT_*} to be added.
     * @return This NetworkCapabilities instance, to facilitate chaining.
     * @hide
     */
    public NetworkCapabilities addTransportType(int transportType) {
        if (transportType < MIN_TRANSPORT || transportType > MAX_TRANSPORT) {
            throw new IllegalArgumentException("TransportType out of range");
        }
        mTransportTypes |= 1 << transportType;
        setNetworkSpecifier(mNetworkSpecifier); // used for exception checking
        return this;
    }


Number 456:
API Relative Path:
src.android.net.NetworkCapabilities.java-removeCapability(int)
Corresponding Source:
/**
     * Removes (if found) the given capability from this {@code NetworkCapability} instance.
     *
     * @param capability the {@code NetworkCapabilities.NET_CAPABILTIY_*} to be removed.
     * @return This NetworkCapabilities instance, to facilitate chaining.
     * @hide
     */
    public NetworkCapabilities removeCapability(int capability) {
        if (capability < MIN_NET_CAPABILITY || capability > MAX_NET_CAPABILITY) {
            throw new IllegalArgumentException("NetworkCapability out of range");
        }
        mNetworkCapabilities &= ~(1 << capability);
        return this;
    }


Number 457:
API Relative Path:
src.android.net.NetworkCapabilities.java-removeTransportType(int)
Corresponding Source:
/**
     * Removes (if found) the given transport from this {@code NetworkCapability} instance.
     *
     * @param transportType the {@code NetworkCapabilities.TRANSPORT_*} to be removed.
     * @return This NetworkCapabilities instance, to facilitate chaining.
     * @hide
     */
    public NetworkCapabilities removeTransportType(int transportType) {
        if (transportType < MIN_TRANSPORT || transportType > MAX_TRANSPORT) {
            throw new IllegalArgumentException("TransportType out of range");
        }
        mTransportTypes &= ~(1 << transportType);
        setNetworkSpecifier(mNetworkSpecifier); // used for exception checking
        return this;
    }


Number 458:
API Relative Path:
src.android.net.NetworkIdentity.java-scrubSubscriberId(String[])
Corresponding Source:
/**
     * Scrub given IMSI on production builds.
     */
    public static String[] scrubSubscriberId(String[] subscriberId) {
        if (subscriberId == null) return null;
        final String[] res = new String[subscriberId.length];
        for (int i = 0; i < res.length; i++) {
            res[i] = NetworkIdentity.scrubSubscriberId(subscriberId[i]);
        }
        return res;
    }


Number 459:
API Relative Path:
src.android.net.NetworkInfo.java-NetworkInfo(NetworkInfo)
Corresponding Source:
/** {@hide} */
    public NetworkInfo(NetworkInfo source) {
        if (source != null) {
            synchronized (source) {
                mNetworkType = source.mNetworkType;
                mSubtype = source.mSubtype;
                mTypeName = source.mTypeName;
                mSubtypeName = source.mSubtypeName;
                mState = source.mState;
                mDetailedState = source.mDetailedState;
                mReason = source.mReason;
                mExtraInfo = source.mExtraInfo;
                mIsFailover = source.mIsFailover;
                mIsAvailable = source.mIsAvailable;
                mIsRoaming = source.mIsRoaming;
                mIsMetered = source.mIsMetered;
            }
        }
    }


Number 460:
API Relative Path:
src.android.net.NetworkPolicyManager.java-computeLastCycleBoundary(long-NetworkPolicy)
Corresponding Source:
/**
     * Compute the last cycle boundary for the given {@link NetworkPolicy}. For
     * example, if cycle day is 20th, and today is June 15th, it will return May
     * 20th. When cycle day doesn't exist in current month, it snaps to the 1st
     * of following month.
     *
     * @hide
     */
    public static long computeLastCycleBoundary(long currentTime, NetworkPolicy policy) {
        if (policy.cycleDay == CYCLE_NONE) {
            throw new IllegalArgumentException("Unable to compute boundary without cycleDay");
        }

        final Time now = new Time(policy.cycleTimezone);
        now.set(currentTime);

        // first, find cycle boundary for current month
        final Time cycle = new Time(now);
        cycle.hour = cycle.minute = cycle.second = 0;
        snapToCycleDay(cycle, policy.cycleDay);

        if (Time.compare(cycle, now) >= 0) {
            // cycle boundary is beyond now, use last cycle boundary; start by
            // pushing ourselves squarely into last month.
            final Time lastMonth = new Time(now);
            lastMonth.hour = lastMonth.minute = lastMonth.second = 0;
            lastMonth.monthDay = 1;
            lastMonth.month -= 1;
            lastMonth.normalize(true);

            cycle.set(lastMonth);
            snapToCycleDay(cycle, policy.cycleDay);
        }

        return cycle.toMillis(true);
    }


Number 461:
API Relative Path:
src.android.net.NetworkPolicyManager.java-computeNextCycleBoundary(long-NetworkPolicy)
Corresponding Source:
/** {@hide} */
    public static long computeNextCycleBoundary(long currentTime, NetworkPolicy policy) {
        if (policy.cycleDay == CYCLE_NONE) {
            throw new IllegalArgumentException("Unable to compute boundary without cycleDay");
        }

        final Time now = new Time(policy.cycleTimezone);
        now.set(currentTime);

        // first, find cycle boundary for current month
        final Time cycle = new Time(now);
        cycle.hour = cycle.minute = cycle.second = 0;
        snapToCycleDay(cycle, policy.cycleDay);

        if (Time.compare(cycle, now) <= 0) {
            // cycle boundary is before now, use next cycle boundary; start by
            // pushing ourselves squarely into next month.
            final Time nextMonth = new Time(now);
            nextMonth.hour = nextMonth.minute = nextMonth.second = 0;
            nextMonth.monthDay = 1;
            nextMonth.month += 1;
            nextMonth.normalize(true);

            cycle.set(nextMonth);
            snapToCycleDay(cycle, policy.cycleDay);
        }

        return cycle.toMillis(true);
    }


Number 462:
API Relative Path:
src.android.net.NetworkRequest.java-NetworkRequest(NetworkCapabilities-int-int)
Corresponding Source:
/**
     * @hide
     */
    public NetworkRequest(NetworkCapabilities nc, int legacyType, int rId) {
        if (nc == null) {
            throw new NullPointerException();
        }
        requestId = rId;
        networkCapabilities = nc;
        this.legacyType = legacyType;
    }


Number 463:
API Relative Path:
src.android.net.NetworkUtils.java-maskRawAddress(byte[]-int)
Corresponding Source:
/**
     *  Masks a raw IP address byte array with the specified prefix length.
     */
    public static void maskRawAddress(byte[] array, int prefixLength) {
        if (prefixLength < 0 || prefixLength > array.length * 8) {
            throw new RuntimeException("IP address with " + array.length +
                    " bytes has invalid prefix length " + prefixLength);
        }

        int offset = prefixLength / 8;
        int remainder = prefixLength % 8;
        byte mask = (byte)(0xFF << (8 - remainder));

        if (offset < array.length) array[offset] = (byte)(array[offset] & mask);

        offset++;

        for (; offset < array.length; offset++) {
            array[offset] = 0;
        }
    }


Number 464:
API Relative Path:
src.android.net.NetworkUtils.java-prefixLengthToNetmaskInt(int)
Corresponding Source:
/**
     * Convert a network prefix length to an IPv4 netmask integer
     * @param prefixLength
     * @return the IPv4 netmask as an integer in network byte order
     */
    public static int prefixLengthToNetmaskInt(int prefixLength)
            throws IllegalArgumentException {
        if (prefixLength < 0 || prefixLength > 32) {
            throw new IllegalArgumentException("Invalid prefix length (0 <= prefix <= 32)");
        }
        int value = 0xffffffff << (32 - prefixLength);
        return Integer.reverseBytes(value);
    }


Number 465:
API Relative Path:
src.android.net.NetworkUtils.java-trimV4AddrZeros(String)
Corresponding Source:
/**
     * Trim leading zeros from IPv4 address strings
     * Our base libraries will interpret that as octel..
     * Must leave non v4 addresses and host names alone.
     * For example, 192.168.000.010 -> 192.168.0.10
     * TODO - fix base libraries and remove this function
     * @param addr a string representing an ip addr
     * @return a string propertly trimmed
     */
    public static String trimV4AddrZeros(String addr) {
        if (addr == null) return null;
        String[] octets = addr.split("\\.");
        if (octets.length != 4) return addr;
        StringBuilder builder = new StringBuilder(16);
        String result = null;
        for (int i = 0; i < 4; i++) {
            try {
                if (octets[i].length() > 3) return addr;
                builder.append(Integer.parseInt(octets[i]));
            } catch (NumberFormatException e) {
                return addr;
            }
            if (i < 3) builder.append('.');
        }
        result = builder.toString();
        return result;
    }


Number 466:
API Relative Path:
src.android.net.nsd.DnsSdTxtRecord.java-DnsSdTxtRecord(DnsSdTxtRecord)
Corresponding Source:
/** Copy constructor */
    public DnsSdTxtRecord(DnsSdTxtRecord src) {
        if (src != null && src.mData != null) {
            mData = (byte[]) src.mData.clone();
        }
    }


Number 467:
API Relative Path:
src.android.net.nsd.NsdManager.java-discoverServices(String-int-DiscoveryListener)
Corresponding Source:
/**
     * Initiate service discovery to browse for instances of a service type. Service discovery
     * consumes network bandwidth and will continue until the application calls
     * {@link #stopServiceDiscovery}.
     *
     * <p> The function call immediately returns after sending a request to start service
     * discovery to the framework. The application is notified of a success to initiate
     * discovery through the callback {@link DiscoveryListener#onDiscoveryStarted} or a failure
     * through {@link DiscoveryListener#onStartDiscoveryFailed}.
     *
     * <p> Upon successful start, application is notified when a service is found with
     * {@link DiscoveryListener#onServiceFound} or when a service is lost with
     * {@link DiscoveryListener#onServiceLost}.
     *
     * <p> Upon failure to start, service discovery is not active and application does
     * not need to invoke {@link #stopServiceDiscovery}
     *
     * <p> The application should call {@link #stopServiceDiscovery} when discovery of this
     * service type is no longer required, and/or whenever the application is paused or
     * stopped.
     *
     * @param serviceType The service type being discovered. Examples include "_http._tcp" for
     * http services or "_ipp._tcp" for printers
     * @param protocolType The service discovery protocol
     * @param listener  The listener notifies of a successful discovery and is used
     * to stop discovery on this serviceType through a call on {@link #stopServiceDiscovery}.
     * Cannot be null. Cannot be in use for an active service discovery.
     */
    public void discoverServices(String serviceType, int protocolType, DiscoveryListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener cannot be null");
        }
        if (TextUtils.isEmpty(serviceType)) {
            throw new IllegalArgumentException("Service type cannot be empty");
        }

        if (protocolType != PROTOCOL_DNS_SD) {
            throw new IllegalArgumentException("Unsupported protocol");
        }

        NsdServiceInfo s = new NsdServiceInfo();
        s.setServiceType(serviceType);

        int key = putListener(listener, s);
        if (key == BUSY_LISTENER_KEY) {
            throw new IllegalArgumentException("listener already in use");
        }

        mAsyncChannel.sendMessage(DISCOVER_SERVICES, 0, key, s);
    }


Number 468:
API Relative Path:
src.android.net.nsd.NsdManager.java-registerService(NsdServiceInfo-int-RegistrationListener)
Corresponding Source:
/**
     * Register a service to be discovered by other services.
     *
     * <p> The function call immediately returns after sending a request to register service
     * to the framework. The application is notified of a successful registration
     * through the callback {@link RegistrationListener#onServiceRegistered} or a failure
     * through {@link RegistrationListener#onRegistrationFailed}.
     *
     * <p> The application should call {@link #unregisterService} when the service
     * registration is no longer required, and/or whenever the application is stopped.
     *
     * @param serviceInfo The service being registered
     * @param protocolType The service discovery protocol
     * @param listener The listener notifies of a successful registration and is used to
     * unregister this service through a call on {@link #unregisterService}. Cannot be null.
     * Cannot be in use for an active service registration.
     */
    public void registerService(NsdServiceInfo serviceInfo, int protocolType,
            RegistrationListener listener) {
        if (TextUtils.isEmpty(serviceInfo.getServiceName()) ||
                TextUtils.isEmpty(serviceInfo.getServiceType())) {
            throw new IllegalArgumentException("Service name or type cannot be empty");
        }
        if (serviceInfo.getPort() <= 0) {
            throw new IllegalArgumentException("Invalid port number");
        }
        if (listener == null) {
            throw new IllegalArgumentException("listener cannot be null");
        }
        if (protocolType != PROTOCOL_DNS_SD) {
            throw new IllegalArgumentException("Unsupported protocol");
        }
        int key = putListener(listener, serviceInfo);
        if (key == BUSY_LISTENER_KEY) {
            throw new IllegalArgumentException("listener already in use");
        }
        mAsyncChannel.sendMessage(REGISTER_SERVICE, 0, key, serviceInfo);
    }


Number 469:
API Relative Path:
src.android.net.nsd.NsdManager.java-stopServiceDiscovery(DiscoveryListener)
Corresponding Source:
/**
     * Stop service discovery initiated with {@link #discoverServices}.  An active service
     * discovery is notified to the application with {@link DiscoveryListener#onDiscoveryStarted}
     * and it stays active until the application invokes a stop service discovery. A successful
     * stop is notified to with a call to {@link DiscoveryListener#onDiscoveryStopped}.
     *
     * <p> Upon failure to stop service discovery, application is notified through
     * {@link DiscoveryListener#onStopDiscoveryFailed}.
     *
     * @param listener This should be the listener object that was passed to {@link #discoverServices}.
     * It identifies the discovery that should be stopped and notifies of a successful or
     * unsuccessful stop.  In API versions 20 and above, the listener object may be used for
     * another service discovery once the callback has been called.  In API versions <= 19,
     * there is no entirely reliable way to know when a listener may be re-used, and a new
     * listener should be created for each service discovery request.
     */
    public void stopServiceDiscovery(DiscoveryListener listener) {
        int id = getListenerKey(listener);
        if (id == INVALID_LISTENER_KEY) {
            throw new IllegalArgumentException("service discovery not active on listener");
        }
        if (listener == null) {
            throw new IllegalArgumentException("listener cannot be null");
        }
        mAsyncChannel.sendMessage(STOP_DISCOVERY, 0, id);
    }


Number 470:
API Relative Path:
src.android.net.nsd.NsdManager.java-unregisterService(RegistrationListener)
Corresponding Source:
/**
     * Unregister a service registered through {@link #registerService}. A successful
     * unregister is notified to the application with a call to
     * {@link RegistrationListener#onServiceUnregistered}.
     *
     * @param listener This should be the listener object that was passed to
     * {@link #registerService}. It identifies the service that should be unregistered
     * and notifies of a successful or unsuccessful unregistration via the listener
     * callbacks.  In API versions 20 and above, the listener object may be used for
     * another service registration once the callback has been called.  In API versions <= 19,
     * there is no entirely reliable way to know when a listener may be re-used, and a new
     * listener should be created for each service registration request.
     */
    public void unregisterService(RegistrationListener listener) {
        int id = getListenerKey(listener);
        if (id == INVALID_LISTENER_KEY) {
            throw new IllegalArgumentException("listener not registered");
        }
        if (listener == null) {
            throw new IllegalArgumentException("listener cannot be null");
        }
        mAsyncChannel.sendMessage(UNREGISTER_SERVICE, 0, id);
    }


Number 471:
API Relative Path:
src.android.net.ProxyInfo.java-ProxyInfo(Uri)
Corresponding Source:
/**
     * Create a ProxyProperties that points at a PAC URL.
     * @hide
     */
    public ProxyInfo(Uri pacFileUrl) {
        mHost = LOCAL_HOST;
        mPort = LOCAL_PORT;
        setExclusionList(LOCAL_EXCL_LIST);
        if (pacFileUrl == null) {
            throw new NullPointerException();
        }
        mPacFileUrl = pacFileUrl;
    }


Number 472:
API Relative Path:
src.android.net.ProxyInfo.java-ProxyInfo(Uri-int)
Corresponding Source:
/**
     * Only used in PacManager after Local Proxy is bound.
     * @hide
     */
    public ProxyInfo(Uri pacFileUrl, int localProxyPort) {
        mHost = LOCAL_HOST;
        mPort = localProxyPort;
        setExclusionList(LOCAL_EXCL_LIST);
        if (pacFileUrl == null) {
            throw new NullPointerException();
        }
        mPacFileUrl = pacFileUrl;
    }


Number 473:
API Relative Path:
src.android.net.RouteInfo.java-makeHostRoute(InetAddress-InetAddress-String)
Corresponding Source:
/**
     * @hide
     */
    public static RouteInfo makeHostRoute(InetAddress host, InetAddress gateway, String iface) {
        if (host == null) return null;

        if (host instanceof Inet4Address) {
            return new RouteInfo(new IpPrefix(host, 32), gateway, iface);
        } else {
            return new RouteInfo(new IpPrefix(host, 128), gateway, iface);
        }
    }


Number 474:
API Relative Path:
src.android.net.RouteInfo.java-RouteInfo(IpPrefix-InetAddress-String-int)
Corresponding Source:
/**
     * Constructs a RouteInfo object.
     *
     * If destination is null, then gateway must be specified and the
     * constructed route is either the IPv4 default route <code>0.0.0.0</code>
     * if the gateway is an instance of {@link Inet4Address}, or the IPv6 default
     * route <code>::/0</code> if gateway is an instance of
     * {@link Inet6Address}.
     * <p>
     * destination and gateway may not both be null.
     *
     * @param destination the destination prefix
     * @param gateway the IP address to route packets through
     * @param iface the interface name to send packets on
     *
     * @hide
     */
    public RouteInfo(IpPrefix destination, InetAddress gateway, String iface, int type) {
        switch (type) {
            case RTN_UNICAST:
            case RTN_UNREACHABLE:
            case RTN_THROW:
                // TODO: It would be nice to ensure that route types that don't have nexthops or
                // interfaces, such as unreachable or throw, can't be created if an interface or
                // a gateway is specified. This is a bit too complicated to do at the moment
                // because:
                //
                // - LinkProperties sets the interface on routes added to it, and modifies the
                //   interfaces of all the routes when its interface name changes.
                // - Even when the gateway is null, we store a non-null gateway here.
                //
                // For now, we just rely on the code that sets routes to do things properly.
                break;
            default:
                throw new IllegalArgumentException("Unknown route type " + type);
        }

        if (destination == null) {
            if (gateway != null) {
                if (gateway instanceof Inet4Address) {
                    destination = new IpPrefix(Inet4Address.ANY, 0);
                } else {
                    destination = new IpPrefix(Inet6Address.ANY, 0);
                }
            } else {
                // no destination, no gateway. invalid.
                throw new IllegalArgumentException("Invalid arguments passed in: " + gateway + "," +
                                                   destination);
            }
        }
        // TODO: set mGateway to null if there is no gateway. This is more correct, saves space, and
        // matches the documented behaviour. Before we can do this we need to fix all callers (e.g.,
        // ConnectivityService) to stop doing things like r.getGateway().equals(), ... .
        if (gateway == null) {
            if (destination.getAddress() instanceof Inet4Address) {
                gateway = Inet4Address.ANY;
            } else {
                gateway = Inet6Address.ANY;
            }
        }
        mHasGateway = (!gateway.isAnyLocalAddress());

        if ((destination.getAddress() instanceof Inet4Address &&
                 (gateway instanceof Inet4Address == false)) ||
                (destination.getAddress() instanceof Inet6Address &&
                 (gateway instanceof Inet6Address == false))) {
            throw new IllegalArgumentException("address family mismatch in RouteInfo constructor");
        }
        mDestination = destination;  // IpPrefix objects are immutable.
        mGateway = gateway;          // InetAddress objects are immutable.
        mInterface = iface;          // Strings are immutable.
        mType = type;
        mIsHost = isHost();
    }


Number 475:
API Relative Path:
src.android.net.RouteInfo.java-RouteInfo(IpPrefix-InetAddress-String-int)
Corresponding Source:
/**
     * Constructs a RouteInfo object.
     *
     * If destination is null, then gateway must be specified and the
     * constructed route is either the IPv4 default route <code>0.0.0.0</code>
     * if the gateway is an instance of {@link Inet4Address}, or the IPv6 default
     * route <code>::/0</code> if gateway is an instance of
     * {@link Inet6Address}.
     * <p>
     * destination and gateway may not both be null.
     *
     * @param destination the destination prefix
     * @param gateway the IP address to route packets through
     * @param iface the interface name to send packets on
     *
     * @hide
     */
    public RouteInfo(IpPrefix destination, InetAddress gateway, String iface, int type) {
        switch (type) {
            case RTN_UNICAST:
            case RTN_UNREACHABLE:
            case RTN_THROW:
                // TODO: It would be nice to ensure that route types that don't have nexthops or
                // interfaces, such as unreachable or throw, can't be created if an interface or
                // a gateway is specified. This is a bit too complicated to do at the moment
                // because:
                //
                // - LinkProperties sets the interface on routes added to it, and modifies the
                //   interfaces of all the routes when its interface name changes.
                // - Even when the gateway is null, we store a non-null gateway here.
                //
                // For now, we just rely on the code that sets routes to do things properly.
                break;
            default:
                throw new IllegalArgumentException("Unknown route type " + type);
        }

        if (destination == null) {
            if (gateway != null) {
                if (gateway instanceof Inet4Address) {
                    destination = new IpPrefix(Inet4Address.ANY, 0);
                } else {
                    destination = new IpPrefix(Inet6Address.ANY, 0);
                }
            } else {
                // no destination, no gateway. invalid.
                throw new IllegalArgumentException("Invalid arguments passed in: " + gateway + "," +
                                                   destination);
            }
        }
        // TODO: set mGateway to null if there is no gateway. This is more correct, saves space, and
        // matches the documented behaviour. Before we can do this we need to fix all callers (e.g.,
        // ConnectivityService) to stop doing things like r.getGateway().equals(), ... .
        if (gateway == null) {
            if (destination.getAddress() instanceof Inet4Address) {
                gateway = Inet4Address.ANY;
            } else {
                gateway = Inet6Address.ANY;
            }
        }
        mHasGateway = (!gateway.isAnyLocalAddress());

        if ((destination.getAddress() instanceof Inet4Address &&
                 (gateway instanceof Inet4Address == false)) ||
                (destination.getAddress() instanceof Inet6Address &&
                 (gateway instanceof Inet6Address == false))) {
            throw new IllegalArgumentException("address family mismatch in RouteInfo constructor");
        }
        mDestination = destination;  // IpPrefix objects are immutable.
        mGateway = gateway;          // InetAddress objects are immutable.
        mInterface = iface;          // Strings are immutable.
        mType = type;
        mIsHost = isHost();
    }


Number 476:
API Relative Path:
src.android.net.RouteInfo.java-selectBestRoute(Collection-InetAddress)
Corresponding Source:
/**
     * Find the route from a Collection of routes that best matches a given address.
     * May return null if no routes are applicable.
     * @param routes a Collection of RouteInfos to chose from
     * @param dest the InetAddress your trying to get to
     * @return the RouteInfo from the Collection that best fits the given address
     *
     * @hide
     */
    public static RouteInfo selectBestRoute(Collection<RouteInfo> routes, InetAddress dest) {
        if ((routes == null) || (dest == null)) return null;

        RouteInfo bestRoute = null;
        // pick a longest prefix match under same address type
        for (RouteInfo route : routes) {
            if (NetworkUtils.addressTypeMatches(route.mDestination.getAddress(), dest)) {
                if ((bestRoute != null) &&
                        (bestRoute.mDestination.getPrefixLength() >=
                        route.mDestination.getPrefixLength())) {
                    continue;
                }
                if (route.matches(dest)) bestRoute = route;
            }
        }
        return bestRoute;
    }


Number 477:
API Relative Path:
src.android.net.RssiCurve.java-RssiCurve(int-int-byte[]-int)
Corresponding Source:
/**
     * Construct a new {@link RssiCurve}.
     *
     * @param start the starting dBm of the curve.
     * @param bucketWidth the width of each RSSI bucket, in dBm.
     * @param rssiBuckets the score for each RSSI bucket.
     * @param activeNetworkRssiBoost the RSSI boost to apply when this network is active, in dBm.
     */
    public RssiCurve(int start, int bucketWidth, byte[] rssiBuckets, int activeNetworkRssiBoost) {
        this.start = start;
        this.bucketWidth = bucketWidth;
        if (rssiBuckets == null || rssiBuckets.length == 0) {
            throw new IllegalArgumentException("rssiBuckets must be at least one element large.");
        }
        this.rssiBuckets = rssiBuckets;
        this.activeNetworkRssiBoost = activeNetworkRssiBoost;
    }


Number 478:
API Relative Path:
src.android.net.rtp.AudioGroup.java-sendDtmf(int)
Corresponding Source:
private native void nativeSendDtmf(int event);


Number 479:
API Relative Path:
src.android.net.rtp.AudioGroup.java-setMode(int)
Corresponding Source:
private native void nativeSetMode(int mode);


Number 480:
API Relative Path:
src.android.net.rtp.AudioStream.java-setCodec(AudioCodec)
Corresponding Source:
/**
     * Sets the {@link AudioCodec}.
     *
     * @param codec The AudioCodec to be used.
     * @throws IllegalArgumentException if its type is used by DTMF.
     * @throws IllegalStateException if the stream is busy.
     */
    public void setCodec(AudioCodec codec) {
        if (isBusy()) {
            throw new IllegalStateException("Busy");
        }
        if (codec.type == mDtmfType) {
            throw new IllegalArgumentException("The type is used by DTMF");
        }
        mCodec = codec;
    }


Number 481:
API Relative Path:
src.android.net.rtp.AudioStream.java-setDtmfType(int)
Corresponding Source:
/**
     * Sets the RTP payload type for dual-tone multi-frequency (DTMF) digits.
     * The primary usage is to send digits to the remote gateway to perform
     * certain tasks, such as second-stage dialing. According to RFC 2833, the
     * RTP payload type for DTMF is assigned dynamically, so it must be in the
     * range of 96 and 127. One can use {@code -1} to disable DTMF and free up
     * the previous assigned type. This method cannot be called when the stream
     * already joined an {@link AudioGroup}.
     *
     * @param type The RTP payload type to be used or {@code -1} to disable it.
     * @throws IllegalArgumentException if the type is invalid or used by codec.
     * @throws IllegalStateException if the stream is busy.
     * @see AudioGroup#sendDtmf(int)
     */
    public void setDtmfType(int type) {
        if (isBusy()) {
            throw new IllegalStateException("Busy");
        }
        if (type != -1) {
            if (type < 96 || type > 127) {
                throw new IllegalArgumentException("Invalid type");
            }
            if (mCodec != null && type == mCodec.type) {
                throw new IllegalArgumentException("The type is used by codec");
            }
        }
        mDtmfType = type;
    }


Number 482:
API Relative Path:
src.android.net.rtp.AudioStream.java-setDtmfType(int)
Corresponding Source:
/**
     * Sets the RTP payload type for dual-tone multi-frequency (DTMF) digits.
     * The primary usage is to send digits to the remote gateway to perform
     * certain tasks, such as second-stage dialing. According to RFC 2833, the
     * RTP payload type for DTMF is assigned dynamically, so it must be in the
     * range of 96 and 127. One can use {@code -1} to disable DTMF and free up
     * the previous assigned type. This method cannot be called when the stream
     * already joined an {@link AudioGroup}.
     *
     * @param type The RTP payload type to be used or {@code -1} to disable it.
     * @throws IllegalArgumentException if the type is invalid or used by codec.
     * @throws IllegalStateException if the stream is busy.
     * @see AudioGroup#sendDtmf(int)
     */
    public void setDtmfType(int type) {
        if (isBusy()) {
            throw new IllegalStateException("Busy");
        }
        if (type != -1) {
            if (type < 96 || type > 127) {
                throw new IllegalArgumentException("Invalid type");
            }
            if (mCodec != null && type == mCodec.type) {
                throw new IllegalArgumentException("The type is used by codec");
            }
        }
        mDtmfType = type;
    }


Number 483:
API Relative Path:
src.android.net.rtp.RtpStream.java-associate(InetAddress-int)
Corresponding Source:
/**
     * Associates with a remote host. This defines the destination of the
     * outgoing packets.
     *
     * @param address The network address of the remote host.
     * @param port The network port of the remote host.
     * @throws IllegalArgumentException if the address is not supported or the
     *     port is invalid.
     * @throws IllegalStateException if the stream is busy.
     * @see #isBusy()
     */
    public void associate(InetAddress address, int port) {
        if (isBusy()) {
            throw new IllegalStateException("Busy");
        }
        if (!(address instanceof Inet4Address && mLocalAddress instanceof Inet4Address) &&
                !(address instanceof Inet6Address && mLocalAddress instanceof Inet6Address)) {
            throw new IllegalArgumentException("Unsupported address");
        }
        if (port < 0 || port > 65535) {
            throw new IllegalArgumentException("Invalid port");
        }
        mRemoteAddress = address;
        mRemotePort = port;
    }


Number 484:
API Relative Path:
src.android.net.rtp.RtpStream.java-associate(InetAddress-int)
Corresponding Source:
/**
     * Associates with a remote host. This defines the destination of the
     * outgoing packets.
     *
     * @param address The network address of the remote host.
     * @param port The network port of the remote host.
     * @throws IllegalArgumentException if the address is not supported or the
     *     port is invalid.
     * @throws IllegalStateException if the stream is busy.
     * @see #isBusy()
     */
    public void associate(InetAddress address, int port) {
        if (isBusy()) {
            throw new IllegalStateException("Busy");
        }
        if (!(address instanceof Inet4Address && mLocalAddress instanceof Inet4Address) &&
                !(address instanceof Inet6Address && mLocalAddress instanceof Inet6Address)) {
            throw new IllegalArgumentException("Unsupported address");
        }
        if (port < 0 || port > 65535) {
            throw new IllegalArgumentException("Invalid port");
        }
        mRemoteAddress = address;
        mRemotePort = port;
    }


Number 485:
API Relative Path:
src.android.net.rtp.RtpStream.java-setMode(int)
Corresponding Source:
/**
     * Changes the current mode. It must be one of {@link #MODE_NORMAL},
     * {@link #MODE_SEND_ONLY}, and {@link #MODE_RECEIVE_ONLY}.
     *
     * @param mode The mode to change to.
     * @throws IllegalArgumentException if the mode is invalid.
     * @throws IllegalStateException if the stream is busy.
     * @see #isBusy()
     */
    public void setMode(int mode) {
        if (isBusy()) {
            throw new IllegalStateException("Busy");
        }
        if (mode < 0 || mode > MODE_LAST) {
            throw new IllegalArgumentException("Invalid mode");
        }
        mMode = mode;
    }


Number 486:
API Relative Path:
src.android.net.SSLCertificateSocketFactory.java-toLengthPrefixedList(byte[])
Corresponding Source:
/**
     * Returns an array containing the concatenation of length-prefixed byte
     * strings.
     */
    static byte[] toLengthPrefixedList(byte[]... items) {
        if (items.length == 0) {
            throw new IllegalArgumentException("items.length == 0");
        }
        int totalLength = 0;
        for (byte[] s : items) {
            if (s.length == 0 || s.length > 255) {
                throw new IllegalArgumentException("s.length == 0 || s.length > 255: " + s.length);
            }
            totalLength += 1 + s.length;
        }
        byte[] result = new byte[totalLength];
        int pos = 0;
        for (byte[] s : items) {
            result[pos++] = (byte) s.length;
            for (byte b : s) {
                result[pos++] = b;
            }
        }
        return result;
    }


Number 487:
API Relative Path:
src.android.net.SSLCertificateSocketFactory.java-verifyHostname(Socket-String)
Corresponding Source:
/**
     * Verify the hostname of the certificate used by the other end of a
     * connected socket.  You MUST call this if you did not supply a hostname
     * to {@link #createSocket()}.  It is harmless to call this method
     * redundantly if the hostname has already been verified.
     *
     * <p>Wildcard certificates are allowed to verify any matching hostname,
     * so "foo.bar.example.com" is verified if the peer has a certificate
     * for "*.example.com".
     *
     * @param socket An SSL socket which has been connected to a server
     * @param hostname The expected hostname of the remote server
     * @throws IOException if something goes wrong handshaking with the server
     * @throws SSLPeerUnverifiedException if the server cannot prove its identity
     *
     * @hide
     */
    public static void verifyHostname(Socket socket, String hostname) throws IOException {
        if (!(socket instanceof SSLSocket)) {
            throw new IllegalArgumentException("Attempt to verify non-SSL socket");
        }

        if (!isSslCheckRelaxed()) {
            // The code at the start of OpenSSLSocketImpl.startHandshake()
            // ensures that the call is idempotent, so we can safely call it.
            SSLSocket ssl = (SSLSocket) socket;
            ssl.startHandshake();

            SSLSession session = ssl.getSession();
            if (session == null) {
                throw new SSLException("Cannot verify SSL socket without session");
            }
            if (!HttpsURLConnection.getDefaultHostnameVerifier().verify(hostname, session)) {
                throw new SSLPeerUnverifiedException("Cannot verify hostname: " + hostname);
            }
        }
    }


Number 488:
API Relative Path:
src.android.net.TrafficStats.java-closeQuietly(INetworkStatsSession)
Corresponding Source:
/** {@hide} */
    public static void closeQuietly(INetworkStatsSession session) {
        // TODO: move to NetworkStatsService once it exists
        if (session != null) {
            try {
                session.close();
            } catch (RuntimeException rethrown) {
                throw rethrown;
            } catch (Exception ignored) {
            }
        }
    }


Number 489:
API Relative Path:
src.android.net.Uri.java-decode(String)
Corresponding Source:
/**
     * Decodes '%'-escaped octets in the given string using the UTF-8 scheme.
     * Replaces invalid octets with the unicode replacement character
     * ("\\uFFFD").
     *
     * @param s encoded string to decode
     * @return the given string with escaped octets decoded, or null if
     *  s is null
     */
    public static String decode(String s) {
        if (s == null) {
            return null;
        }
        return UriCodec.decode(s, false, StandardCharsets.UTF_8, false);
    }


Number 490:
API Relative Path:
src.android.net.Uri.java-encode(String-String)
Corresponding Source:
/**
     * Encodes characters in the given string as '%'-escaped octets
     * using the UTF-8 scheme. Leaves letters ("A-Z", "a-z"), numbers
     * ("0-9"), and unreserved characters ("_-!.~'()*") intact. Encodes
     * all other characters with the exception of those specified in the
     * allow argument.
     *
     * @param s string to encode
     * @param allow set of additional characters to allow in the encoded form,
     *  null if no characters should be skipped
     * @return an encoded version of s suitable for use as a URI component,
     *  or null if s is null
     */
    public static String encode(String s, String allow) {
        if (s == null) {
            return null;
        }

        // Lazily-initialized buffers.
        StringBuilder encoded = null;

        int oldLength = s.length();

        // This loop alternates between copying over allowed characters and
        // encoding in chunks. This results in fewer method calls and
        // allocations than encoding one character at a time.
        int current = 0;
        while (current < oldLength) {
            // Start in "copying" mode where we copy over allowed chars.

            // Find the next character which needs to be encoded.
            int nextToEncode = current;
            while (nextToEncode < oldLength
                    && isAllowed(s.charAt(nextToEncode), allow)) {
                nextToEncode++;
            }

            // If there's nothing more to encode...
            if (nextToEncode == oldLength) {
                if (current == 0) {
                    // We didn't need to encode anything!
                    return s;
                } else {
                    // Presumably, we've already done some encoding.
                    encoded.append(s, current, oldLength);
                    return encoded.toString();
                }
            }

            if (encoded == null) {
                encoded = new StringBuilder();
            }

            if (nextToEncode > current) {
                // Append allowed characters leading up to this point.
                encoded.append(s, current, nextToEncode);
            } else {
                // assert nextToEncode == current
            }

            // Switch to "encoding" mode.

            // Find the next allowed character.
            current = nextToEncode;
            int nextAllowed = current + 1;
            while (nextAllowed < oldLength
                    && !isAllowed(s.charAt(nextAllowed), allow)) {
                nextAllowed++;
            }

            // Convert the substring to bytes and encode the bytes as
            // '%'-escaped octets.
            String toEncode = s.substring(current, nextAllowed);
            try {
                byte[] bytes = toEncode.getBytes(DEFAULT_ENCODING);
                int bytesLength = bytes.length;
                for (int i = 0; i < bytesLength; i++) {
                    encoded.append('%');
                    encoded.append(HEX_DIGITS[(bytes[i] & 0xf0) >> 4]);
                    encoded.append(HEX_DIGITS[bytes[i] & 0xf]);
                }
            } catch (UnsupportedEncodingException e) {
                throw new AssertionError(e);
            }

            current = nextAllowed;
        }

        // Encoded could still be null at this point if s is empty.
        return encoded == null ? s : encoded.toString();
    }


Number 491:
API Relative Path:
src.android.net.WebAddress.java-WebAddress(String)
Corresponding Source:
/** parses given uriString. */
    public WebAddress(String address) throws ParseException {
        if (address == null) {
            throw new NullPointerException();
        }

        // android.util.Log.d(LOGTAG, "WebAddress: " + address);

        mScheme = "";
        mHost = "";
        mPort = -1;
        mPath = "/";
        mAuthInfo = "";

        Matcher m = sAddressPattern.matcher(address);
        String t;
        if (m.matches()) {
            t = m.group(MATCH_GROUP_SCHEME);
            if (t != null) mScheme = t.toLowerCase(Locale.ROOT);
            t = m.group(MATCH_GROUP_AUTHORITY);
            if (t != null) mAuthInfo = t;
            t = m.group(MATCH_GROUP_HOST);
            if (t != null) mHost = t;
            t = m.group(MATCH_GROUP_PORT);
            if (t != null && t.length() > 0) {
                // The ':' character is not returned by the regex.
                try {
                    mPort = Integer.parseInt(t);
                } catch (NumberFormatException ex) {
                    throw new ParseException("Bad port");
                }
            }
            t = m.group(MATCH_GROUP_PATH);
            if (t != null && t.length() > 0) {
                /* handle busted myspace frontpage redirect with
                   missing initial "/" */
                if (t.charAt(0) == '/') {
                    mPath = t;
                } else {
                    mPath = "/" + t;
                }
            }

        } else {
            // nothing found... outa here
            throw new ParseException("Bad address");
        }

        /* Get port from scheme or scheme from port, if necessary and
           possible */
        if (mPort == 443 && mScheme.equals("")) {
            mScheme = "https";
        } else if (mPort == -1) {
            if (mScheme.equals("https"))
                mPort = 443;
            else
                mPort = 80; // default
        }
        if (mScheme.equals("")) mScheme = "http";
    }


Number 492:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-publish(int-PublishData-PublishSettings)
Corresponding Source:
/**
     * {@hide}
     */
    public void publish(int sessionId, PublishData publishData, PublishSettings publishSettings) {
        if (VDBG) Log.v(TAG, "publish(): data='" + publishData + "', settings=" + publishSettings);

        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_UNSOLICITED
                && publishData.mRxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: UNSOLICITED "
                    + "publishes (active) can't have an Rx filter");
        }
        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_SOLICITED
                && publishData.mTxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: SOLICITED "
                    + "publishes (passive) can't have a Tx filter");
        }

        try {
            mService.publish(sessionId, publishData, publishSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 493:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-publish(int-PublishData-PublishSettings)
Corresponding Source:
/**
     * {@hide}
     */
    public void publish(int sessionId, PublishData publishData, PublishSettings publishSettings) {
        if (VDBG) Log.v(TAG, "publish(): data='" + publishData + "', settings=" + publishSettings);

        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_UNSOLICITED
                && publishData.mRxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: UNSOLICITED "
                    + "publishes (active) can't have an Rx filter");
        }
        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_SOLICITED
                && publishData.mTxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: SOLICITED "
                    + "publishes (passive) can't have a Tx filter");
        }

        try {
            mService.publish(sessionId, publishData, publishSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 494:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-publishRaw(PublishData-PublishSettings-WifiNanSessionListener-int)
Corresponding Source:
/**
     * Same as publish(*) but does not modify the event flag
     *
     * @hide
     */
    public WifiNanPublishSession publishRaw(PublishData publishData,
            PublishSettings publishSettings, WifiNanSessionListener listener, int events) {
        if (VDBG) Log.v(TAG, "publish(): data='" + publishData + "', settings=" + publishSettings);

        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_UNSOLICITED
                && publishData.mRxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: UNSOLICITED "
                    + "publishes (active) can't have an Rx filter");
        }
        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_SOLICITED
                && publishData.mTxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: SOLICITED "
                    + "publishes (passive) can't have a Tx filter");
        }
        if (listener == null) {
            throw new IllegalArgumentException("Invalid listener - must not be null");
        }

        int sessionId;

        try {
            sessionId = mService.createSession(listener.callback, events);
            if (DBG) Log.d(TAG, "publish: session created - sessionId=" + sessionId);
            mService.publish(sessionId, publishData, publishSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }

        return new WifiNanPublishSession(this, sessionId);
    }


Number 495:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-publishRaw(PublishData-PublishSettings-WifiNanSessionListener-int)
Corresponding Source:
/**
     * Same as publish(*) but does not modify the event flag
     *
     * @hide
     */
    public WifiNanPublishSession publishRaw(PublishData publishData,
            PublishSettings publishSettings, WifiNanSessionListener listener, int events) {
        if (VDBG) Log.v(TAG, "publish(): data='" + publishData + "', settings=" + publishSettings);

        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_UNSOLICITED
                && publishData.mRxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: UNSOLICITED "
                    + "publishes (active) can't have an Rx filter");
        }
        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_SOLICITED
                && publishData.mTxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: SOLICITED "
                    + "publishes (passive) can't have a Tx filter");
        }
        if (listener == null) {
            throw new IllegalArgumentException("Invalid listener - must not be null");
        }

        int sessionId;

        try {
            sessionId = mService.createSession(listener.callback, events);
            if (DBG) Log.d(TAG, "publish: session created - sessionId=" + sessionId);
            mService.publish(sessionId, publishData, publishSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }

        return new WifiNanPublishSession(this, sessionId);
    }


Number 496:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-publishRaw(PublishData-PublishSettings-WifiNanSessionListener-int)
Corresponding Source:
/**
     * Same as publish(*) but does not modify the event flag
     *
     * @hide
     */
    public WifiNanPublishSession publishRaw(PublishData publishData,
            PublishSettings publishSettings, WifiNanSessionListener listener, int events) {
        if (VDBG) Log.v(TAG, "publish(): data='" + publishData + "', settings=" + publishSettings);

        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_UNSOLICITED
                && publishData.mRxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: UNSOLICITED "
                    + "publishes (active) can't have an Rx filter");
        }
        if (publishSettings.mPublishType == PublishSettings.PUBLISH_TYPE_SOLICITED
                && publishData.mTxFilterLength != 0) {
            throw new IllegalArgumentException("Invalid publish data & settings: SOLICITED "
                    + "publishes (passive) can't have a Tx filter");
        }
        if (listener == null) {
            throw new IllegalArgumentException("Invalid listener - must not be null");
        }

        int sessionId;

        try {
            sessionId = mService.createSession(listener.callback, events);
            if (DBG) Log.d(TAG, "publish: session created - sessionId=" + sessionId);
            mService.publish(sessionId, publishData, publishSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }

        return new WifiNanPublishSession(this, sessionId);
    }


Number 497:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-subscribe(int-SubscribeData-SubscribeSettings)
Corresponding Source:
/**
     * {@hide}
     */
    public void subscribe(int sessionId, SubscribeData subscribeData,
            SubscribeSettings subscribeSettings) {
        if (VDBG) {
            Log.v(TAG, "subscribe(): data='" + subscribeData + "', settings=" + subscribeSettings);
        }

        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_ACTIVE
                && subscribeData.mRxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: ACTIVE subscribes can't have an Rx filter");
        }
        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_PASSIVE
                && subscribeData.mTxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: PASSIVE subscribes can't have a Tx filter");
        }

        try {
            mService.subscribe(sessionId, subscribeData, subscribeSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 498:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-subscribe(int-SubscribeData-SubscribeSettings)
Corresponding Source:
/**
     * {@hide}
     */
    public void subscribe(int sessionId, SubscribeData subscribeData,
            SubscribeSettings subscribeSettings) {
        if (VDBG) {
            Log.v(TAG, "subscribe(): data='" + subscribeData + "', settings=" + subscribeSettings);
        }

        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_ACTIVE
                && subscribeData.mRxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: ACTIVE subscribes can't have an Rx filter");
        }
        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_PASSIVE
                && subscribeData.mTxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: PASSIVE subscribes can't have a Tx filter");
        }

        try {
            mService.subscribe(sessionId, subscribeData, subscribeSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 499:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-subscribeRaw(SubscribeData-SubscribeSettings-WifiNanSessionListener-int)
Corresponding Source:
/**
     * Same as subscribe(*) but does not modify the event flag
     *
     * @hide
     */
    public WifiNanSubscribeSession subscribeRaw(SubscribeData subscribeData,
            SubscribeSettings subscribeSettings, WifiNanSessionListener listener, int events) {
        if (VDBG) {
            Log.v(TAG, "subscribe(): data='" + subscribeData + "', settings=" + subscribeSettings);
        }

        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_ACTIVE
                && subscribeData.mRxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: ACTIVE subscribes can't have an Rx filter");
        }
        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_PASSIVE
                && subscribeData.mTxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: PASSIVE subscribes can't have a Tx filter");
        }

        int sessionId;

        try {
            sessionId = mService.createSession(listener.callback, events);
            if (DBG) Log.d(TAG, "subscribe: session created - sessionId=" + sessionId);
            mService.subscribe(sessionId, subscribeData, subscribeSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }

        return new WifiNanSubscribeSession(this, sessionId);
    }


Number 500:
API Relative Path:
src.android.net.wifi.nan.WifiNanManager.java-subscribeRaw(SubscribeData-SubscribeSettings-WifiNanSessionListener-int)
Corresponding Source:
/**
     * Same as subscribe(*) but does not modify the event flag
     *
     * @hide
     */
    public WifiNanSubscribeSession subscribeRaw(SubscribeData subscribeData,
            SubscribeSettings subscribeSettings, WifiNanSessionListener listener, int events) {
        if (VDBG) {
            Log.v(TAG, "subscribe(): data='" + subscribeData + "', settings=" + subscribeSettings);
        }

        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_ACTIVE
                && subscribeData.mRxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: ACTIVE subscribes can't have an Rx filter");
        }
        if (subscribeSettings.mSubscribeType == SubscribeSettings.SUBSCRIBE_TYPE_PASSIVE
                && subscribeData.mTxFilterLength != 0) {
            throw new IllegalArgumentException(
                    "Invalid subscribe data & settings: PASSIVE subscribes can't have a Tx filter");
        }

        int sessionId;

        try {
            sessionId = mService.createSession(listener.callback, events);
            if (DBG) Log.d(TAG, "subscribe: session created - sessionId=" + sessionId);
            mService.subscribe(sessionId, subscribeData, subscribeSettings);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }

        return new WifiNanSubscribeSession(this, sessionId);
    }


Number 501:
API Relative Path:
src.android.net.wifi.p2p.nsd.WifiP2pDnsSdServiceRequest.java-newInstance(String)
Corresponding Source:
/**
     * Create a service discovery to search for Bonjour services with the specified
     * service type.
     *
     * @param serviceType service type. Cannot be null <br>
     *  "_afpovertcp._tcp."(Apple File Sharing over TCP)<br>
     *  "_ipp._tcp" (IP Printing over TCP)<br>
     *  "_http._tcp" (http service)
     * @return service request for DnsSd.
     */
    public static WifiP2pDnsSdServiceRequest newInstance(String serviceType) {
        if (serviceType == null) {
            throw new IllegalArgumentException("service type cannot be null");
        }
        return new WifiP2pDnsSdServiceRequest(serviceType + ".local.",
                WifiP2pDnsSdServiceInfo.DNS_TYPE_PTR,
                WifiP2pDnsSdServiceInfo.VERSION_1);
    }


Number 502:
API Relative Path:
src.android.net.wifi.p2p.nsd.WifiP2pDnsSdServiceRequest.java-newInstance(String-String)
Corresponding Source:
/**
     * Create a service discovery request to get the TXT data from the specified
     * Bonjour service.
     *
     * @param instanceName instance name. Cannot be null. <br>
     *  "MyPrinter"
     * @param serviceType service type. Cannot be null. <br>
     * e.g) <br>
     *  "_afpovertcp._tcp"(Apple File Sharing over TCP)<br>
     *  "_ipp._tcp" (IP Printing over TCP)<br>
     * @return service request for Bonjour.
     */
    public static WifiP2pDnsSdServiceRequest newInstance(String instanceName,
            String serviceType) {
        if (instanceName == null || serviceType == null) {
            throw new IllegalArgumentException(
                    "instance name or service type cannot be null");
        }
        String fullDomainName = instanceName + "." + serviceType + ".local.";
        return new WifiP2pDnsSdServiceRequest(fullDomainName,
                WifiP2pDnsSdServiceInfo.DNS_TYPE_TXT,
                WifiP2pDnsSdServiceInfo.VERSION_1);
    }


Number 503:
API Relative Path:
src.android.net.wifi.p2p.nsd.WifiP2pServiceInfo.java-WifiP2pServiceInfo(List)
Corresponding Source:
/**
     * This is only used in subclass.
     *
     * @param queryList query string for wpa_supplicant
     * @hide
     */
    protected WifiP2pServiceInfo(List<String> queryList) {
        if (queryList == null) {
            throw new IllegalArgumentException("query list cannot be null");
        }
        mQueryList = queryList;
    }


Number 504:
API Relative Path:
src.android.net.wifi.p2p.nsd.WifiP2pServiceResponse.java-setSrcDevice(WifiP2pDevice)
Corresponding Source:
/** @hide */
    public void setSrcDevice(WifiP2pDevice dev) {
        if (dev == null) return;
        this.mDevice = dev;
    }


Number 505:
API Relative Path:
src.android.net.wifi.p2p.nsd.WifiP2pUpnpServiceInfo.java-newInstance(String-String-List)
Corresponding Source:
/**
     * Create UPnP service information object.
     *
     * @param uuid a string representation of this UUID in the following format,
     *  as per <a href="http://www.ietf.org/rfc/rfc4122.txt">RFC 4122</a>.<br>
     *  e.g) 6859dede-8574-59ab-9332-123456789012
     * @param device a string representation of this device in the following format,
     * as per
     * <a href="http://www.upnp.org/specs/arch/UPnP-arch-DeviceArchitecture-v1.1.pdf">
     *  UPnP Device Architecture1.1</a><br>
     *  e.g) urn:schemas-upnp-org:device:MediaServer:1
     * @param services a string representation of this service in the following format,
     * as per
     * <a href="http://www.upnp.org/specs/arch/UPnP-arch-DeviceArchitecture-v1.1.pdf">
     *  UPnP Device Architecture1.1</a><br>
     *  e.g) urn:schemas-upnp-org:service:ContentDirectory:1
     * @return UPnP service information object.
     */
    public static WifiP2pUpnpServiceInfo newInstance(String uuid,
            String device, List<String> services) {
        if (uuid == null || device == null) {
            throw new IllegalArgumentException("uuid or device cannnot be null");
        }
        UUID.fromString(uuid);

        ArrayList<String> info = new ArrayList<String>();

        info.add(createSupplicantQuery(uuid, null));
        info.add(createSupplicantQuery(uuid, "upnp:rootdevice"));
        info.add(createSupplicantQuery(uuid, device));
        if (services != null) {
            for (String service:services) {
                info.add(createSupplicantQuery(uuid, service));
            }
        }

        return new WifiP2pUpnpServiceInfo(info);
    }


Number 506:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pConfig.java-WifiP2pConfig(WifiP2pConfig)
Corresponding Source:
/** copy constructor */
    public WifiP2pConfig(WifiP2pConfig source) {
        if (source != null) {
            deviceAddress = source.deviceAddress;
            wps = new WpsInfo(source.wps);
            groupOwnerIntent = source.groupOwnerIntent;
            netId = source.netId;
        }
    }


Number 507:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pDevice.java-updateSupplicantDetails(WifiP2pDevice)
Corresponding Source:
/** Updates details obtained from supplicant @hide */
    public void updateSupplicantDetails(WifiP2pDevice device) {
        if (device == null) {
            throw new IllegalArgumentException("device is null");
        }
        if (device.deviceAddress == null) {
            throw new IllegalArgumentException("deviceAddress is null");
        }
        if (!deviceAddress.equals(device.deviceAddress)) {
            throw new IllegalArgumentException("deviceAddress does not match");
        }
        deviceName = device.deviceName;
        primaryDeviceType = device.primaryDeviceType;
        secondaryDeviceType = device.secondaryDeviceType;
        wpsConfigMethodsSupported = device.wpsConfigMethodsSupported;
        deviceCapability = device.deviceCapability;
        groupCapability = device.groupCapability;
        wfdInfo = device.wfdInfo;
    }


Number 508:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pDevice.java-updateSupplicantDetails(WifiP2pDevice)
Corresponding Source:
/** Updates details obtained from supplicant @hide */
    public void updateSupplicantDetails(WifiP2pDevice device) {
        if (device == null) {
            throw new IllegalArgumentException("device is null");
        }
        if (device.deviceAddress == null) {
            throw new IllegalArgumentException("deviceAddress is null");
        }
        if (!deviceAddress.equals(device.deviceAddress)) {
            throw new IllegalArgumentException("deviceAddress does not match");
        }
        deviceName = device.deviceName;
        primaryDeviceType = device.primaryDeviceType;
        secondaryDeviceType = device.secondaryDeviceType;
        wpsConfigMethodsSupported = device.wpsConfigMethodsSupported;
        deviceCapability = device.deviceCapability;
        groupCapability = device.groupCapability;
        wfdInfo = device.wfdInfo;
    }


Number 509:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pDevice.java-WifiP2pDevice(WifiP2pDevice)
Corresponding Source:
/** copy constructor */
    public WifiP2pDevice(WifiP2pDevice source) {
        if (source != null) {
            deviceName = source.deviceName;
            deviceAddress = source.deviceAddress;
            primaryDeviceType = source.primaryDeviceType;
            secondaryDeviceType = source.secondaryDeviceType;
            wpsConfigMethodsSupported = source.wpsConfigMethodsSupported;
            deviceCapability = source.deviceCapability;
            groupCapability = source.groupCapability;
            status = source.status;
            wfdInfo = new WifiP2pWfdInfo(source.wfdInfo);
        }
    }


Number 510:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pDeviceList.java-WifiP2pDeviceList(WifiP2pDeviceList)
Corresponding Source:
/** copy constructor */
    public WifiP2pDeviceList(WifiP2pDeviceList source) {
        if (source != null) {
            for (WifiP2pDevice d : source.getDeviceList()) {
                mDevices.put(d.deviceAddress, new WifiP2pDevice(d));
            }
        }
    }


Number 511:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pGroup.java-WifiP2pGroup(WifiP2pGroup)
Corresponding Source:
/** copy constructor */
    public WifiP2pGroup(WifiP2pGroup source) {
        if (source != null) {
            mNetworkName = source.getNetworkName();
            mOwner = new WifiP2pDevice(source.getOwner());
            mIsGroupOwner = source.mIsGroupOwner;
            for (WifiP2pDevice d : source.getClientList()) mClients.add(d);
            mPassphrase = source.getPassphrase();
            mInterface = source.getInterface();
            mNetId = source.getNetworkId();
        }
    }


Number 512:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pGroupList.java-WifiP2pGroupList(WifiP2pGroupList-GroupDeleteListener)
Corresponding Source:
/** @hide */
    public WifiP2pGroupList(WifiP2pGroupList source, GroupDeleteListener listener) {
        mListener = listener;
        mGroups = new LruCache<Integer, WifiP2pGroup>(CREDENTIAL_MAX_NUM) {
            @Override
            protected void entryRemoved(boolean evicted, Integer netId,
                    WifiP2pGroup oldValue, WifiP2pGroup newValue) {
                if (mListener != null && !isClearCalled) {
                    mListener.onDeleteGroup(oldValue.getNetworkId());
                }
            }
        };

        if (source != null) {
            for (Map.Entry<Integer, WifiP2pGroup> item : source.mGroups.snapshot().entrySet()) {
                mGroups.put(item.getKey(), item.getValue());
            }
        }
    }


Number 513:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pInfo.java-WifiP2pInfo(WifiP2pInfo)
Corresponding Source:
/** copy constructor */
    public WifiP2pInfo(WifiP2pInfo source) {
        if (source != null) {
            groupFormed = source.groupFormed;
            isGroupOwner = source.isGroupOwner;
            groupOwnerAddress = source.groupOwnerAddress;
       }
    }


Number 514:
API Relative Path:
src.android.net.wifi.p2p.WifiP2pWfdInfo.java-WifiP2pWfdInfo(WifiP2pWfdInfo)
Corresponding Source:
/** copy constructor */
    public WifiP2pWfdInfo(WifiP2pWfdInfo source) {
        if (source != null) {
            mWfdEnabled = source.mWfdEnabled;
            mDeviceInfo = source.mDeviceInfo;
            mCtrlPort = source.mCtrlPort;
            mMaxThroughput = source.mMaxThroughput;
        }
    }


Number 515:
API Relative Path:
src.android.net.wifi.ScanResult.java-ScanResult(ScanResult)
Corresponding Source:
/** copy constructor {@hide} */
    public ScanResult(ScanResult source) {
        if (source != null) {
            wifiSsid = source.wifiSsid;
            SSID = source.SSID;
            BSSID = source.BSSID;
            hessid = source.hessid;
            anqpDomainId = source.anqpDomainId;
            informationElements = source.informationElements;
            anqpElements = source.anqpElements;
            capabilities = source.capabilities;
            level = source.level;
            frequency = source.frequency;
            channelWidth = source.channelWidth;
            centerFreq0 = source.centerFreq0;
            centerFreq1 = source.centerFreq1;
            timestamp = source.timestamp;
            distanceCm = source.distanceCm;
            distanceSdCm = source.distanceSdCm;
            seen = source.seen;
            untrusted = source.untrusted;
            numConnection = source.numConnection;
            numUsage = source.numUsage;
            numIpConfigFailures = source.numIpConfigFailures;
            isAutoJoinCandidate = source.isAutoJoinCandidate;
            venueName = source.venueName;
            operatorFriendlyName = source.operatorFriendlyName;
            flags = source.flags;
        }
    }


Number 516:
API Relative Path:
src.android.net.wifi.ScanSettings.java-ScanSettings(ScanSettings)
Corresponding Source:
/** copy constructor */
    public ScanSettings(ScanSettings source) {
        if (source.channelSet != null)
            channelSet = new ArrayList<WifiChannel>(source.channelSet);
    }


Number 517:
API Relative Path:
src.android.net.wifi.WifiConfiguration.java-WifiConfiguration(WifiConfiguration)
Corresponding Source:
/** copy constructor {@hide} */
    public WifiConfiguration(WifiConfiguration source) {
        if (source != null) {
            networkId = source.networkId;
            status = source.status;
            SSID = source.SSID;
            BSSID = source.BSSID;
            FQDN = source.FQDN;
            roamingConsortiumIds = source.roamingConsortiumIds.clone();
            providerFriendlyName = source.providerFriendlyName;
            preSharedKey = source.preSharedKey;

            mNetworkSelectionStatus.copy(source.getNetworkSelectionStatus());
            apBand = source.apBand;
            apChannel = source.apChannel;

            wepKeys = new String[4];
            for (int i = 0; i < wepKeys.length; i++) {
                wepKeys[i] = source.wepKeys[i];
            }

            wepTxKeyIndex = source.wepTxKeyIndex;
            priority = source.priority;
            hiddenSSID = source.hiddenSSID;
            allowedKeyManagement   = (BitSet) source.allowedKeyManagement.clone();
            allowedProtocols       = (BitSet) source.allowedProtocols.clone();
            allowedAuthAlgorithms  = (BitSet) source.allowedAuthAlgorithms.clone();
            allowedPairwiseCiphers = (BitSet) source.allowedPairwiseCiphers.clone();
            allowedGroupCiphers    = (BitSet) source.allowedGroupCiphers.clone();
            enterpriseConfig = new WifiEnterpriseConfig(source.enterpriseConfig);

            defaultGwMacAddress = source.defaultGwMacAddress;

            mIpConfiguration = new IpConfiguration(source.mIpConfiguration);

            if ((source.linkedConfigurations != null)
                    && (source.linkedConfigurations.size() > 0)) {
                linkedConfigurations = new HashMap<String, Integer>();
                linkedConfigurations.putAll(source.linkedConfigurations);
            }
            mCachedConfigKey = null; //force null configKey
            selfAdded = source.selfAdded;
            validatedInternetAccess = source.validatedInternetAccess;
            ephemeral = source.ephemeral;
            meteredHint = source.meteredHint;
            useExternalScores = source.useExternalScores;
            if (source.visibility != null) {
                visibility = new Visibility(source.visibility);
            }

            lastFailure = source.lastFailure;
            didSelfAdd = source.didSelfAdd;
            lastConnectUid = source.lastConnectUid;
            lastUpdateUid = source.lastUpdateUid;
            creatorUid = source.creatorUid;
            creatorName = source.creatorName;
            lastUpdateName = source.lastUpdateName;
            peerWifiConfiguration = source.peerWifiConfiguration;

            lastConnected = source.lastConnected;
            lastDisconnected = source.lastDisconnected;
            lastConnectionFailure = source.lastConnectionFailure;
            lastRoamingFailure = source.lastRoamingFailure;
            lastRoamingFailureReason = source.lastRoamingFailureReason;
            roamingFailureBlackListTimeMilli = source.roamingFailureBlackListTimeMilli;
            numScorerOverride = source.numScorerOverride;
            numScorerOverrideAndSwitchedNetwork = source.numScorerOverrideAndSwitchedNetwork;
            numAssociation = source.numAssociation;
            numUserTriggeredWifiDisableLowRSSI = source.numUserTriggeredWifiDisableLowRSSI;
            numUserTriggeredWifiDisableBadRSSI = source.numUserTriggeredWifiDisableBadRSSI;
            numUserTriggeredWifiDisableNotHighRSSI = source.numUserTriggeredWifiDisableNotHighRSSI;
            numTicksAtLowRSSI = source.numTicksAtLowRSSI;
            numTicksAtBadRSSI = source.numTicksAtBadRSSI;
            numTicksAtNotHighRSSI = source.numTicksAtNotHighRSSI;
            numUserTriggeredJoinAttempts = source.numUserTriggeredJoinAttempts;
            userApproved = source.userApproved;
            numNoInternetAccessReports = source.numNoInternetAccessReports;
            noInternetAccessExpected = source.noInternetAccessExpected;
            creationTime = source.creationTime;
            updateTime = source.updateTime;
            shared = source.shared;
        }
    }


Number 518:
API Relative Path:
src.android.net.wifi.WifiConnectionStatistics.java-WifiConnectionStatistics(WifiConnectionStatistics)
Corresponding Source:
/** copy constructor*/
    public WifiConnectionStatistics(WifiConnectionStatistics source) {
        untrustedNetworkHistory = new HashMap<String, WifiNetworkConnectionStatistics>();
        if (source != null) {
            untrustedNetworkHistory.putAll(source.untrustedNetworkHistory);
        }
    }


Number 519:
API Relative Path:
src.android.net.wifi.WifiEnterpriseConfig.java-setClientKeyEntry(PrivateKey-X509Certificate)
Corresponding Source:
/**
     * Specify a private key and client certificate for client authorization.
     *
     * <p>A default name is automatically assigned to the key entry and used
     * with this configuration.  The framework takes care of installing the
     * key entry when the config is saved and removing the key entry when
     * the config is removed.

     * @param privateKey
     * @param clientCertificate
     * @throws IllegalArgumentException for an invalid key or certificate.
     */
    public void setClientKeyEntry(PrivateKey privateKey, X509Certificate clientCertificate) {
        if (clientCertificate != null) {
            if (clientCertificate.getBasicConstraints() != -1) {
                throw new IllegalArgumentException("Cannot be a CA certificate");
            }
            if (privateKey == null) {
                throw new IllegalArgumentException("Client cert without a private key");
            }
            if (privateKey.getEncoded() == null) {
                throw new IllegalArgumentException("Private key cannot be encoded");
            }
        }

        mClientPrivateKey = privateKey;
        mClientCertificate = clientCertificate;
    }


Number 520:
API Relative Path:
src.android.net.wifi.WifiInfo.java-removeDoubleQuotes(String)
Corresponding Source:
/** {@hide} */
    public static String removeDoubleQuotes(String string) {
        if (string == null) return null;
        final int length = string.length();
        if ((length > 1) && (string.charAt(0) == '"') && (string.charAt(length - 1) == '"')) {
            return string.substring(1, length - 1);
        }
        return string;
    }


Number 521:
API Relative Path:
src.android.net.wifi.WifiInfo.java-WifiInfo(WifiInfo)
Corresponding Source:
/**
     * Copy constructor
     * @hide
     */
    public WifiInfo(WifiInfo source) {
        if (source != null) {
            mSupplicantState = source.mSupplicantState;
            mBSSID = source.mBSSID;
            mWifiSsid = source.mWifiSsid;
            mNetworkId = source.mNetworkId;
            mRssi = source.mRssi;
            mLinkSpeed = source.mLinkSpeed;
            mFrequency = source.mFrequency;
            mIpAddress = source.mIpAddress;
            mMacAddress = source.mMacAddress;
            mMeteredHint = source.mMeteredHint;
            mEphemeral = source.mEphemeral;
            txBad = source.txBad;
            txRetries = source.txRetries;
            txSuccess = source.txSuccess;
            rxSuccess = source.rxSuccess;
            txBadRate = source.txBadRate;
            txRetriesRate = source.txRetriesRate;
            txSuccessRate = source.txSuccessRate;
            rxSuccessRate = source.rxSuccessRate;
            score = source.score;
            badRssiCount = source.badRssiCount;
            lowRssiCount = source.lowRssiCount;
            linkStuckCount = source.linkStuckCount;
        }
    }


Number 522:
API Relative Path:
src.android.net.wifi.WifiManager.java-connect(int-ActionListener)
Corresponding Source:
/**
     * Connect to a network with the given networkId.
     *
     * This function is used instead of a enableNetwork(), saveConfiguration() and
     * reconnect()
     *
     * @param networkId the network id identifiying the network in the
     *                supplicant configuration list
     * @param listener for callbacks on success or failure. Can be null.
     * @throws IllegalStateException if the WifiManager instance needs to be
     * initialized again
     * @hide
     */
    public void connect(int networkId, ActionListener listener) {
        if (networkId < 0) throw new IllegalArgumentException("Network id cannot be negative");
        getChannel().sendMessage(CONNECT_NETWORK, networkId, putListener(listener));
    }


Number 523:
API Relative Path:
src.android.net.wifi.WifiManager.java-connect(WifiConfiguration-ActionListener)
Corresponding Source:
/**
     * Connect to a network with the given configuration. The network also
     * gets added to the supplicant configuration.
     *
     * For a new network, this function is used instead of a
     * sequence of addNetwork(), enableNetwork(), saveConfiguration() and
     * reconnect()
     *
     * @param config the set of variables that describe the configuration,
     *            contained in a {@link WifiConfiguration} object.
     * @param listener for callbacks on success or failure. Can be null.
     * @throws IllegalStateException if the WifiManager instance needs to be
     * initialized again
     *
     * @hide
     */
    public void connect(WifiConfiguration config, ActionListener listener) {
        if (config == null) throw new IllegalArgumentException("config cannot be null");
        // Use INVALID_NETWORK_ID for arg1 when passing a config object
        // arg1 is used to pass network id when the network already exists
        getChannel().sendMessage(CONNECT_NETWORK, WifiConfiguration.INVALID_NETWORK_ID,
                putListener(listener), config);
    }


Number 524:
API Relative Path:
src.android.net.wifi.WifiManager.java-disable(int-ActionListener)
Corresponding Source:
/**
     * Disable network
     *
     * @param netId is the network Id
     * @param listener for callbacks on success or failure. Can be null.
     * @throws IllegalStateException if the WifiManager instance needs to be
     * initialized again
     * @hide
     */
    public void disable(int netId, ActionListener listener) {
        if (netId < 0) throw new IllegalArgumentException("Network id cannot be negative");
        getChannel().sendMessage(DISABLE_NETWORK, netId, putListener(listener));
    }


Number 525:
API Relative Path:
src.android.net.wifi.WifiManager.java-disableEphemeralNetwork(String)
Corresponding Source:
/**
     * Disable ephemeral Network
     *
     * @param SSID, in the format of WifiConfiguration's SSID.
     * @hide
     */
    public void disableEphemeralNetwork(String SSID) {
        if (SSID == null) throw new IllegalArgumentException("SSID cannot be null");
        try {
            mService.disableEphemeralNetwork(SSID);
        } catch (RemoteException e) {
            throw e.rethrowFromSystemServer();
        }
    }


Number 526:
API Relative Path:
src.android.net.wifi.WifiManager.java-forget(int-ActionListener)
Corresponding Source:
/**
     * Delete the network in the supplicant config.
     *
     * This function is used instead of a sequence of removeNetwork()
     * and saveConfiguration().
     *
     * @param config the set of variables that describe the configuration,
     *            contained in a {@link WifiConfiguration} object.
     * @param listener for callbacks on success or failure. Can be null.
     * @throws IllegalStateException if the WifiManager instance needs to be
     * initialized again
     * @hide
     */
    public void forget(int netId, ActionListener listener) {
        if (netId < 0) throw new IllegalArgumentException("Network id cannot be negative");
        getChannel().sendMessage(FORGET_NETWORK, netId, putListener(listener));
    }


Number 527:
API Relative Path:
src.android.net.wifi.WifiManager.java-save(WifiConfiguration-ActionListener)
Corresponding Source:
/**
     * Save the given network in the supplicant config. If the network already
     * exists, the configuration is updated. A new network is enabled
     * by default.
     *
     * For a new network, this function is used instead of a
     * sequence of addNetwork(), enableNetwork() and saveConfiguration().
     *
     * For an existing network, it accomplishes the task of updateNetwork()
     * and saveConfiguration()
     *
     * @param config the set of variables that describe the configuration,
     *            contained in a {@link WifiConfiguration} object.
     * @param listener for callbacks on success or failure. Can be null.
     * @throws IllegalStateException if the WifiManager instance needs to be
     * initialized again
     * @hide
     */
    public void save(WifiConfiguration config, ActionListener listener) {
        if (config == null) throw new IllegalArgumentException("config cannot be null");
        getChannel().sendMessage(SAVE_NETWORK, 0, putListener(listener), config);
    }


Number 528:
API Relative Path:
src.android.net.wifi.WifiManager.java-startWps(WpsInfo-WpsCallback)
Corresponding Source:
/**
     * Start Wi-fi Protected Setup
     *
     * @param config WPS configuration (does not support {@link WpsInfo#LABEL})
     * @param listener for callbacks on success or failure. Can be null.
     * @throws IllegalStateException if the WifiManager instance needs to be
     * initialized again
     */
    public void startWps(WpsInfo config, WpsCallback listener) {
        if (config == null) throw new IllegalArgumentException("config cannot be null");
        getChannel().sendMessage(START_WPS, 0, putListener(listener), config);
    }


Number 529:
API Relative Path:
src.android.net.wifi.WpsResult.java-WpsResult(WpsResult)
Corresponding Source:
/** copy constructor {@hide} */
    public WpsResult(WpsResult source) {
        if (source != null) {
            status = source.status;
            pin = source.pin;
        }
    }


Number 530:
API Relative Path:
src.android.service.carrier.MessagePdu.java-MessagePdu(List)
Corresponding Source:
/**
     * Constructs a MessagePdu with the list of message PDUs.
     *
     * @param pduList the list of message PDUs
     */
    public MessagePdu(@NonNull List<byte[]> pduList) {
        if (pduList == null || pduList.contains(null)) {
            throw new IllegalArgumentException("pduList must not be null or contain nulls");
        }
        mPduList = pduList;
    }


Number 531:
API Relative Path:
src.android.service.chooser.ChooserTarget.java-ChooserTarget(CharSequence-Icon-float-ComponentName-Bundle)
Corresponding Source:
/**
     * Construct a deep link target for presentation by a chooser UI.
     *
     * <p>A target is composed of a title and an icon for presentation to the user.
     * The UI presenting this target may truncate the title if it is too long to be presented
     * in the available space, as well as crop, resize or overlay the supplied icon.</p>
     *
     * <p>The creator of a target may supply a ranking score. This score is assumed to be relative
     * to the other targets supplied by the same
     * {@link ChooserTargetService#onGetChooserTargets(ComponentName, IntentFilter) query}.
     * Scores should be in the range from 0.0f (unlikely match) to 1.0f (very relevant match).
     * Scores for a set of targets do not need to sum to 1.</p>
     *
     * <p>The ComponentName must be the name of an Activity component in the creator's own
     * package, or an exported component from any other package. You may provide an optional
     * Bundle of extras that will be merged into the final intent before it is sent to the
     * target Activity; use this to add any additional data about the deep link that the target
     * activity will read. e.g. conversation IDs, email addresses, etc.</p>
     *
     * <p>Take care not to place custom {@link android.os.Parcelable} types into
     * the extras bundle, as the system will not be able to unparcel them to merge them.</p>
     *
     * @param title title of this target that will be shown to a user
     * @param icon icon to represent this target
     * @param score ranking score for this target between 0.0f and 1.0f, inclusive
     * @param componentName Name of the component to be launched if this target is chosen
     * @param intentExtras Bundle of extras to merge with the extras of the launched intent
     */
    public ChooserTarget(CharSequence title, Icon icon, float score,
            ComponentName componentName, @Nullable Bundle intentExtras) {
        mTitle = title;
        mIcon = icon;
        if (score > 1.f || score < 0.f) {
            throw new IllegalArgumentException("Score " + score + " out of range; "
                    + "must be between 0.0f and 1.0f");
        }
        mScore = score;
        mComponentName = componentName;
        mIntentExtras = intentExtras;
    }


Number 532:
API Relative Path:
src.android.service.media.MediaBrowserService.java-notifyChildrenChanged(String-Bundle)
Corresponding Source:
/**
     * Notifies all connected media browsers that the children of
     * the specified parent id have changed in some way.
     * This will cause browsers to fetch subscribed content again.
     *
     * @param parentId The id of the parent media item whose
     *            children changed.
     * @param options A bundle of service-specific arguments to send
     *            to the media browse. The contents of this bundle may
     *            contain the information about the change.
     */
    public void notifyChildrenChanged(@NonNull String parentId, @NonNull Bundle options) {
        if (options == null) {
            throw new IllegalArgumentException("options cannot be null in notifyChildrenChanged");
        }
        notifyChildrenChangedInternal(parentId, options);
    }


Number 533:
API Relative Path:
src.android.service.notification.ConditionProviderService.java-notifyCondition(Condition)
Corresponding Source:
/**
     * Informs the notification manager that the state of a Condition has changed. Use this method
     * to put the system into Do Not Disturb mode or request that it exits Do Not Disturb mode. This
     * call will be ignored unless there is an enabled {@link android.app.AutomaticZenRule} owned by
     * service that has an {@link android.app.AutomaticZenRule#getConditionId()} equal to this
     * {@link Condition#id}.
     * @param condition the condition that has changed.
     */
    public final void notifyCondition(Condition condition) {
        if (condition == null) return;
        notifyConditions(new Condition[]{ condition });
    }


Number 534:
API Relative Path:
src.android.service.notification.ConditionProviderService.java-notifyConditions(Condition)
Corresponding Source:
/**
     * Informs the notification manager that the state of one or more Conditions has changed. See
     * {@link #notifyCondition(Condition)} for restrictions.
     * @param conditions the changed conditions.
     */
    public final void notifyConditions(Condition... conditions) {
        if (!isBound() || conditions == null) return;
        try {
            getNotificationInterface().notifyConditions(getPackageName(), mProvider, conditions);
        } catch (android.os.RemoteException ex) {
            Log.v(TAG, "Unable to contact notification manager", ex);
        }
    }


Number 535:
API Relative Path:
src.android.service.notification.StatusBarNotification.java-StatusBarNotification(String-String-int-String-int-int-Notification-UserHandle-String-long)
Corresponding Source:
/** @hide */
    public StatusBarNotification(String pkg, String opPkg, int id, String tag, int uid,
            int initialPid, Notification notification, UserHandle user, String overrideGroupKey,
            long postTime) {
        if (pkg == null) throw new NullPointerException();
        if (notification == null) throw new NullPointerException();

        this.pkg = pkg;
        this.opPkg = opPkg;
        this.id = id;
        this.tag = tag;
        this.uid = uid;
        this.initialPid = initialPid;
        this.notification = notification;
        this.user = user;
        this.postTime = postTime;
        this.overrideGroupKey = overrideGroupKey;
        this.key = key();
        this.groupKey = groupKey();
    }


Number 536:
API Relative Path:
src.android.service.notification.StatusBarNotification.java-StatusBarNotification(String-String-int-String-int-int-Notification-UserHandle-String-long)
Corresponding Source:
/** @hide */
    public StatusBarNotification(String pkg, String opPkg, int id, String tag, int uid,
            int initialPid, Notification notification, UserHandle user, String overrideGroupKey,
            long postTime) {
        if (pkg == null) throw new NullPointerException();
        if (notification == null) throw new NullPointerException();

        this.pkg = pkg;
        this.opPkg = opPkg;
        this.id = id;
        this.tag = tag;
        this.uid = uid;
        this.initialPid = initialPid;
        this.notification = notification;
        this.user = user;
        this.postTime = postTime;
        this.overrideGroupKey = overrideGroupKey;
        this.key = key();
        this.groupKey = groupKey();
    }


Number 537:
API Relative Path:
src.android.view.AbsSavedState.java-AbsSavedState(Parcelable)
Corresponding Source:
/**
     * Constructor called by derived classes when creating their SavedState objects
     *
     * @param superState The state of the superclass of this view
     */
    protected AbsSavedState(Parcelable superState) {
        if (superState == null) {
            throw new IllegalArgumentException("superState must not be null");
        }
        mSuperState = superState != EMPTY_STATE ? superState : null;
    }


Number 538:
API Relative Path:
src.android.view.accessibility.AccessibilityInteractionClient.java-findAccessibilityNodeInfoByAccessibilityId(int-int-long-boolean-int)
Corresponding Source:
/**
     * Finds an {@link AccessibilityNodeInfo} by accessibility id.
     *
     * @param connectionId The id of a connection for interacting with the system.
     * @param accessibilityWindowId A unique window id. Use
     *     {@link android.view.accessibility.AccessibilityNodeInfo#ACTIVE_WINDOW_ID}
     *     to query the currently active window.
     * @param accessibilityNodeId A unique view id or virtual descendant id from
     *     where to start the search. Use
     *     {@link android.view.accessibility.AccessibilityNodeInfo#ROOT_NODE_ID}
     *     to start from the root.
     * @param bypassCache Whether to bypass the cache while looking for the node.
     * @param prefetchFlags flags to guide prefetching.
     * @return An {@link AccessibilityNodeInfo} if found, null otherwise.
     */
    public AccessibilityNodeInfo findAccessibilityNodeInfoByAccessibilityId(int connectionId,
            int accessibilityWindowId, long accessibilityNodeId, boolean bypassCache,
            int prefetchFlags) {
        if ((prefetchFlags & AccessibilityNodeInfo.FLAG_PREFETCH_SIBLINGS) != 0
                && (prefetchFlags & AccessibilityNodeInfo.FLAG_PREFETCH_PREDECESSORS) == 0) {
            throw new IllegalArgumentException("FLAG_PREFETCH_SIBLINGS"
                + " requires FLAG_PREFETCH_PREDECESSORS");
        }
        try {
            IAccessibilityServiceConnection connection = getConnection(connectionId);
            if (connection != null) {
                if (!bypassCache) {
                    AccessibilityNodeInfo cachedInfo = sAccessibilityCache.getNode(
                            accessibilityWindowId, accessibilityNodeId);
                    if (cachedInfo != null) {
                        if (DEBUG) {
                            Log.i(LOG_TAG, "Node cache hit");
                        }
                        return cachedInfo;
                    }
                    if (DEBUG) {
                        Log.i(LOG_TAG, "Node cache miss");
                    }
                }
                final int interactionId = mInteractionIdCounter.getAndIncrement();
                final long identityToken = Binder.clearCallingIdentity();
                final boolean success = connection.findAccessibilityNodeInfoByAccessibilityId(
                        accessibilityWindowId, accessibilityNodeId, interactionId, this,
                        prefetchFlags, Thread.currentThread().getId());
                Binder.restoreCallingIdentity(identityToken);
                // If the scale is zero the call has failed.
                if (success) {
                    List<AccessibilityNodeInfo> infos = getFindAccessibilityNodeInfosResultAndClear(
                            interactionId);
                    finalizeAndCacheAccessibilityNodeInfos(infos, connectionId);
                    if (infos != null && !infos.isEmpty()) {
                        return infos.get(0);
                    }
                }
            } else {
                if (DEBUG) {
                    Log.w(LOG_TAG, "No connection for connection id: " + connectionId);
                }
            }
        } catch (RemoteException re) {
            Log.e(LOG_TAG, "Error while calling remote"
                    + " findAccessibilityNodeInfoByAccessibilityId", re);
        }
        return null;
    }


Number 539:
API Relative Path:
src.android.view.accessibility.AccessibilityNodeInfo.java-addAction(int)
Corresponding Source:
/**
     * Adds an action that can be performed on the node.
     * <p>
     *   <strong>Note:</strong> Cannot be called from an
     *   {@link android.accessibilityservice.AccessibilityService}.
     *   This class is made immutable before being delivered to an AccessibilityService.
     * </p>
     *
     * @param action The action.
     *
     * @throws IllegalStateException If called from an AccessibilityService.
     * @throws IllegalArgumentException If the argument is not one of the standard actions.
     *
     * @deprecated This has been deprecated for {@link #addAction(AccessibilityAction)}
     */
    @Deprecated
    public void addAction(int action) {
        enforceNotSealed();

        if ((action & ACTION_TYPE_MASK) != 0) {
            throw new IllegalArgumentException("Action is not a combination of the standard " +
                    "actions: " + action);
        }

        addLegacyStandardActions(action);
    }


Number 540:
API Relative Path:
src.android.view.accessibility.AccessibilityWindowInfo.java-changed(AccessibilityWindowInfo)
Corresponding Source:
/**
     * Checks whether this window changed. The argument should be
     * another state of the same window, which is have the same id
     * and type as they never change.
     *
     * @param other The new state.
     * @return Whether something changed.
     *
     * @hide
     */
    public boolean changed(AccessibilityWindowInfo other) {
        if (other.mId != mId) {
            throw new IllegalArgumentException("Not same window.");
        }
        if (other.mType != mType) {
            throw new IllegalArgumentException("Not same type.");
        }
        if (!mBoundsInScreen.equals(other.mBoundsInScreen)) {
            return true;
        }
        if (mLayer != other.mLayer) {
            return true;
        }
        if (mBooleanProperties != other.mBooleanProperties) {
            return true;
        }
        if (mParentId != other.mParentId) {
            return true;
        }
        if (mChildIds == null) {
            if (other.mChildIds != null) {
                return true;
            }
        } else if (!mChildIds.equals(other.mChildIds)) {
            return true;
        }
        return false;
    }


Number 541:
API Relative Path:
src.android.view.accessibility.AccessibilityWindowInfo.java-changed(AccessibilityWindowInfo)
Corresponding Source:
/**
     * Checks whether this window changed. The argument should be
     * another state of the same window, which is have the same id
     * and type as they never change.
     *
     * @param other The new state.
     * @return Whether something changed.
     *
     * @hide
     */
    public boolean changed(AccessibilityWindowInfo other) {
        if (other.mId != mId) {
            throw new IllegalArgumentException("Not same window.");
        }
        if (other.mType != mType) {
            throw new IllegalArgumentException("Not same type.");
        }
        if (!mBoundsInScreen.equals(other.mBoundsInScreen)) {
            return true;
        }
        if (mLayer != other.mLayer) {
            return true;
        }
        if (mBooleanProperties != other.mBooleanProperties) {
            return true;
        }
        if (mParentId != other.mParentId) {
            return true;
        }
        if (mChildIds == null) {
            if (other.mChildIds != null) {
                return true;
            }
        } else if (!mChildIds.equals(other.mChildIds)) {
            return true;
        }
        return false;
    }


Number 542:
API Relative Path:
src.android.view.animation.Animation.java-setDuration(long)
Corresponding Source:
/**
     * How long this animation should last. The duration cannot be negative.
     * 
     * @param durationMillis Duration in milliseconds
     *
     * @throws java.lang.IllegalArgumentException if the duration is < 0
     *
     * @attr ref android.R.styleable#Animation_duration
     */
    public void setDuration(long durationMillis) {
        if (durationMillis < 0) {
            throw new IllegalArgumentException("Animation duration cannot be negative");
        }
        mDuration = durationMillis;
    }


Number 543:
API Relative Path:
src.android.view.animation.ClipRectAnimation.java-ClipRectAnimation(Rect-Rect)
Corresponding Source:
/**
     * Constructor to use when building a ClipRectAnimation from code
     *
     * @param fromClip the clip rect to animate from
     * @param toClip the clip rect to animate to
     */
    public ClipRectAnimation(Rect fromClip, Rect toClip) {
        if (fromClip == null || toClip == null) {
            throw new RuntimeException("Expected non-null animation clip rects");
        }
        mFromRect.set(fromClip);
        mToRect.set(toClip);
    }


Number 544:
API Relative Path:
src.android.view.Choreographer.java-postCallbackDelayed(int-Runnable-Object-long)
Corresponding Source:
/**
     * Posts a callback to run on the next frame after the specified delay.
     * <p>
     * The callback runs once then is automatically removed.
     * </p>
     *
     * @param callbackType The callback type.
     * @param action The callback action to run during the next frame after the specified delay.
     * @param token The callback token, or null if none.
     * @param delayMillis The delay time in milliseconds.
     *
     * @see #removeCallback
     * @hide
     */
    public void postCallbackDelayed(int callbackType,
            Runnable action, Object token, long delayMillis) {
        if (action == null) {
            throw new IllegalArgumentException("action must not be null");
        }
        if (callbackType < 0 || callbackType > CALLBACK_LAST) {
            throw new IllegalArgumentException("callbackType is invalid");
        }

        postCallbackDelayedInternal(callbackType, action, token, delayMillis);
    }


Number 545:
API Relative Path:
src.android.view.Choreographer.java-postCallbackDelayed(int-Runnable-Object-long)
Corresponding Source:
/**
     * Posts a callback to run on the next frame after the specified delay.
     * <p>
     * The callback runs once then is automatically removed.
     * </p>
     *
     * @param callbackType The callback type.
     * @param action The callback action to run during the next frame after the specified delay.
     * @param token The callback token, or null if none.
     * @param delayMillis The delay time in milliseconds.
     *
     * @see #removeCallback
     * @hide
     */
    public void postCallbackDelayed(int callbackType,
            Runnable action, Object token, long delayMillis) {
        if (action == null) {
            throw new IllegalArgumentException("action must not be null");
        }
        if (callbackType < 0 || callbackType > CALLBACK_LAST) {
            throw new IllegalArgumentException("callbackType is invalid");
        }

        postCallbackDelayedInternal(callbackType, action, token, delayMillis);
    }


Number 546:
API Relative Path:
src.android.view.Choreographer.java-postFrameCallbackDelayed(FrameCallback-long)
Corresponding Source:
/**
     * Posts a frame callback to run on the next frame after the specified delay.
     * <p>
     * The callback runs once then is automatically removed.
     * </p>
     *
     * @param callback The frame callback to run during the next frame.
     * @param delayMillis The delay time in milliseconds.
     *
     * @see #postFrameCallback
     * @see #removeFrameCallback
     */
    public void postFrameCallbackDelayed(FrameCallback callback, long delayMillis) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null");
        }

        postCallbackDelayedInternal(CALLBACK_ANIMATION,
                callback, FRAME_CALLBACK_TOKEN, delayMillis);
    }


Number 547:
API Relative Path:
src.android.view.Choreographer.java-removeCallbacks(int-Runnable-Object)
Corresponding Source:
/**
     * Removes callbacks that have the specified action and token.
     *
     * @param callbackType The callback type.
     * @param action The action property of the callbacks to remove, or null to remove
     * callbacks with any action.
     * @param token The token property of the callbacks to remove, or null to remove
     * callbacks with any token.
     *
     * @see #postCallback
     * @see #postCallbackDelayed
     * @hide
     */
    public void removeCallbacks(int callbackType, Runnable action, Object token) {
        if (callbackType < 0 || callbackType > CALLBACK_LAST) {
            throw new IllegalArgumentException("callbackType is invalid");
        }

        removeCallbacksInternal(callbackType, action, token);
    }


Number 548:
API Relative Path:
src.android.view.Choreographer.java-removeFrameCallback(FrameCallback)
Corresponding Source:
/**
     * Removes a previously posted frame callback.
     *
     * @param callback The frame callback to remove.
     *
     * @see #postFrameCallback
     * @see #postFrameCallbackDelayed
     */
    public void removeFrameCallback(FrameCallback callback) {
        if (callback == null) {
            throw new IllegalArgumentException("callback must not be null");
        }

        removeCallbacksInternal(CALLBACK_ANIMATION, callback, FRAME_CALLBACK_TOKEN);
    }


Number 549:
API Relative Path:
src.android.view.DisplayEventReceiver.java-DisplayEventReceiver(Looper)
Corresponding Source:
/**
     * Creates a display event receiver.
     *
     * @param looper The looper to use when invoking callbacks.
     */
    public DisplayEventReceiver(Looper looper) {
        if (looper == null) {
            throw new IllegalArgumentException("looper must not be null");
        }

        mMessageQueue = looper.getQueue();
        mReceiverPtr = nativeInit(new WeakReference<DisplayEventReceiver>(this), mMessageQueue);

        mCloseGuard.open("dispose");
    }


Number 550:
API Relative Path:
src.android.view.InputChannel.java-openInputChannelPair(String)
Corresponding Source:
/**
     * Creates a new input channel pair.  One channel should be provided to the input
     * dispatcher and the other to the application's input queue.
     * @param name The descriptive (non-unique) name of the channel pair.
     * @return A pair of input channels.  The first channel is designated as the
     * server channel and should be used to publish input events.  The second channel
     * is designated as the client channel and should be used to consume input events.
     */
    public static InputChannel[] openInputChannelPair(String name) {
        if (name == null) {
            throw new IllegalArgumentException("name must not be null");
        }

        if (DEBUG) {
            Slog.d(TAG, "Opening input channel pair '" + name + "'");
        }
        return nativeOpenInputChannelPair(name);
    }


Number 551:
API Relative Path:
src.android.view.InputChannel.java-transferTo(InputChannel)
Corresponding Source:
/**
     * Transfers ownership of the internal state of the input channel to another
     * instance and invalidates this instance.  This is used to pass an input channel
     * as an out parameter in a binder call.
     * @param other The other input channel instance.
     */
    public void transferTo(InputChannel outParameter) {
        if (outParameter == null) {
            throw new IllegalArgumentException("outParameter must not be null");
        }
        
        nativeTransferTo(outParameter);
    }


Number 552:
API Relative Path:
src.android.view.InputEventReceiver.java-finishInputEvent(InputEvent-boolean)
Corresponding Source:
/**
     * Finishes an input event and indicates whether it was handled.
     * Must be called on the same Looper thread to which the receiver is attached.
     *
     * @param event The input event that was finished.
     * @param handled True if the event was handled.
     */
    public final void finishInputEvent(InputEvent event, boolean handled) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        }
        if (mReceiverPtr == 0) {
            Log.w(TAG, "Attempted to finish an input event but the input event "
                    + "receiver has already been disposed.");
        } else {
            int index = mSeqMap.indexOfKey(event.getSequenceNumber());
            if (index < 0) {
                Log.w(TAG, "Attempted to finish an input event that is not in progress.");
            } else {
                int seq = mSeqMap.valueAt(index);
                mSeqMap.removeAt(index);
                nativeFinishInputEvent(mReceiverPtr, seq, handled);
            }
        }
        event.recycleIfNeededAfterDispatch();
    }


Number 553:
API Relative Path:
src.android.view.InputEventReceiver.java-InputEventReceiver(InputChannel-Looper)
Corresponding Source:
/**
     * Creates an input event receiver bound to the specified input channel.
     *
     * @param inputChannel The input channel.
     * @param looper The looper to use when invoking callbacks.
     */
    public InputEventReceiver(InputChannel inputChannel, Looper looper) {
        if (inputChannel == null) {
            throw new IllegalArgumentException("inputChannel must not be null");
        }
        if (looper == null) {
            throw new IllegalArgumentException("looper must not be null");
        }

        mInputChannel = inputChannel;
        mMessageQueue = looper.getQueue();
        mReceiverPtr = nativeInit(new WeakReference<InputEventReceiver>(this),
                inputChannel, mMessageQueue);

        mCloseGuard.open("dispose");
    }


Number 554:
API Relative Path:
src.android.view.InputEventReceiver.java-InputEventReceiver(InputChannel-Looper)
Corresponding Source:
/**
     * Creates an input event receiver bound to the specified input channel.
     *
     * @param inputChannel The input channel.
     * @param looper The looper to use when invoking callbacks.
     */
    public InputEventReceiver(InputChannel inputChannel, Looper looper) {
        if (inputChannel == null) {
            throw new IllegalArgumentException("inputChannel must not be null");
        }
        if (looper == null) {
            throw new IllegalArgumentException("looper must not be null");
        }

        mInputChannel = inputChannel;
        mMessageQueue = looper.getQueue();
        mReceiverPtr = nativeInit(new WeakReference<InputEventReceiver>(this),
                inputChannel, mMessageQueue);

        mCloseGuard.open("dispose");
    }


Number 555:
API Relative Path:
src.android.view.InputEventSender.java-InputEventSender(InputChannel-Looper)
Corresponding Source:
/**
     * Creates an input event sender bound to the specified input channel.
     *
     * @param inputChannel The input channel.
     * @param looper The looper to use when invoking callbacks.
     */
    public InputEventSender(InputChannel inputChannel, Looper looper) {
        if (inputChannel == null) {
            throw new IllegalArgumentException("inputChannel must not be null");
        }
        if (looper == null) {
            throw new IllegalArgumentException("looper must not be null");
        }

        mInputChannel = inputChannel;
        mMessageQueue = looper.getQueue();
        mSenderPtr = nativeInit(new WeakReference<InputEventSender>(this),
                inputChannel, mMessageQueue);

        mCloseGuard.open("dispose");
    }


Number 556:
API Relative Path:
src.android.view.InputEventSender.java-InputEventSender(InputChannel-Looper)
Corresponding Source:
/**
     * Creates an input event sender bound to the specified input channel.
     *
     * @param inputChannel The input channel.
     * @param looper The looper to use when invoking callbacks.
     */
    public InputEventSender(InputChannel inputChannel, Looper looper) {
        if (inputChannel == null) {
            throw new IllegalArgumentException("inputChannel must not be null");
        }
        if (looper == null) {
            throw new IllegalArgumentException("looper must not be null");
        }

        mInputChannel = inputChannel;
        mMessageQueue = looper.getQueue();
        mSenderPtr = nativeInit(new WeakReference<InputEventSender>(this),
                inputChannel, mMessageQueue);

        mCloseGuard.open("dispose");
    }


Number 557:
API Relative Path:
src.android.view.InputEventSender.java-sendInputEvent(int-InputEvent)
Corresponding Source:
/**
     * Sends an input event.
     * Must be called on the same Looper thread to which the sender is attached.
     *
     * @param seq The input event sequence number.
     * @param event The input event to send.
     * @return True if the entire event was sent successfully.  May return false
     * if the input channel buffer filled before all samples were dispatched.
     */
    public final boolean sendInputEvent(int seq, InputEvent event) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        }
        if (mSenderPtr == 0) {
            Log.w(TAG, "Attempted to send an input event but the input event "
                    + "sender has already been disposed.");
            return false;
        }

        if (event instanceof KeyEvent) {
            return nativeSendKeyEvent(mSenderPtr, seq, (KeyEvent)event);
        } else {
            return nativeSendMotionEvent(mSenderPtr, seq, (MotionEvent)event);
        }
    }


Number 558:
API Relative Path:
src.android.view.InputFilter.java-sendInputEvent(InputEvent-int)
Corresponding Source:
/**
     * Sends an input event to the dispatcher.
     *
     * @param event The input event to publish.
     * @param policyFlags The input event policy flags.
     */
    public void sendInputEvent(InputEvent event, int policyFlags) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        }
        if (mHost == null) {
            throw new IllegalStateException("Cannot send input event because the input filter " +
                    "is not installed.");
        }
        if (mOutboundInputEventConsistencyVerifier != null) {
            mOutboundInputEventConsistencyVerifier.onInputEvent(event, 0);
        }
        try {
            mHost.sendInputEvent(event, policyFlags);
        } catch (RemoteException re) {
            /* ignore */
        }
    }


Number 559:
API Relative Path:
src.android.view.inputmethod.InputMethodManager.java-toggleSoftInputFromWindow(IBinder-int-int)
Corresponding Source:
/**
     * This method toggles the input method window display.
     * If the input window is already displayed, it gets hidden. 
     * If not the input window will be displayed.
     * @param windowToken The token of the window that is making the request,
     * as returned by {@link View#getWindowToken() View.getWindowToken()}.
     * @param showFlags Provides additional operating flags.  May be
     * 0 or have the {@link #SHOW_IMPLICIT},
     * {@link #SHOW_FORCED} bit set.
     * @param hideFlags Provides additional operating flags.  May be
     * 0 or have the {@link #HIDE_IMPLICIT_ONLY},
     * {@link #HIDE_NOT_ALWAYS} bit set.
     **/
    public void toggleSoftInputFromWindow(IBinder windowToken, int showFlags, int hideFlags) {
        synchronized (mH) {
            if (mServedView == null || mServedView.getWindowToken() != windowToken) {
                return;
            }
            if (mCurMethod != null) {
                try {
                    mCurMethod.toggleSoftInput(showFlags, hideFlags);
                } catch (RemoteException e) {
                }
            }
        }
    }


Number 560:
API Relative Path:
src.android.view.inputmethod.InputMethodManager.java-updateCursorAnchorInfo(View-CursorAnchorInfo)
Corresponding Source:
/**
     * Report positional change of the text insertion point and/or characters in the composition
     * string.
     */
    public void updateCursorAnchorInfo(View view, final CursorAnchorInfo cursorAnchorInfo) {
        if (view == null || cursorAnchorInfo == null) {
            return;
        }
        checkFocus();
        synchronized (mH) {
            if ((mServedView != view &&
                    (mServedView == null || !mServedView.checkInputConnectionProxy(view)))
                    || mCurrentTextBoxAttribute == null || mCurMethod == null) {
                return;
            }
            // If immediate bit is set, we will call updateCursorAnchorInfo() even when the data has
            // not been changed from the previous call.
            final boolean isImmediate = (mRequestUpdateCursorAnchorInfoMonitorMode &
                    InputConnection.CURSOR_UPDATE_IMMEDIATE) != 0;
            if (!isImmediate && Objects.equals(mCursorAnchorInfo, cursorAnchorInfo)) {
                // TODO: Consider always emitting this message once we have addressed redundant
                // calls of this method from android.widget.Editor.
                if (DEBUG) {
                    Log.w(TAG, "Ignoring redundant updateCursorAnchorInfo: info="
                            + cursorAnchorInfo);
                }
                return;
            }
            if (DEBUG) Log.v(TAG, "updateCursorAnchorInfo: " + cursorAnchorInfo);
            try {
                mCurMethod.updateCursorAnchorInfo(cursorAnchorInfo);
                mCursorAnchorInfo = cursorAnchorInfo;
                // Clear immediate bit (if any).
                mRequestUpdateCursorAnchorInfoMonitorMode &=
                        ~InputConnection.CURSOR_UPDATE_IMMEDIATE;
            } catch (RemoteException e) {
                Log.w(TAG, "IME died: " + mCurId, e);
            }
        }
    }


Number 561:
API Relative Path:
src.android.view.inputmethod.InputMethodSubtypeArray.java-get(int)
Corresponding Source:
/**
     * Return {@link InputMethodSubtype} specified with the given index.
     *
     * <p>This methods may take a bit additional time to decompress data lazily when called
     * first time.</p>
     *
     * @param index The index of {@link InputMethodSubtype}.
     */
    public InputMethodSubtype get(final int index) {
        if (index < 0 || mCount <= index) {
            throw new ArrayIndexOutOfBoundsException();
        }
        InputMethodSubtype[] instance = mInstance;
        if (instance == null) {
            synchronized (mLockObject) {
                instance = mInstance;
                if (instance == null) {
                    final byte[] decompressedData =
                          decompress(mCompressedData, mDecompressedSize);
                    // Clear the compressed data until {@link #getMarshalled()} is called.
                    mCompressedData = null;
                    mDecompressedSize = 0;
                    if (decompressedData != null) {
                        instance = unmarshall(decompressedData);
                    } else {
                        Slog.e(TAG, "Failed to decompress data. Returns null as fallback.");
                        instance = new InputMethodSubtype[mCount];
                    }
                    mInstance = instance;
                }
            }
        }
        return instance[index];
    }


Number 562:
API Relative Path:
src.android.view.inputmethod.InputMethodSubtypeArray.java-InputMethodSubtypeArray(List)
Corresponding Source:
/**
     * Create a new instance of {@link InputMethodSubtypeArray} from an existing list of
     * {@link InputMethodSubtype}.
     *
     * @param subtypes A list of {@link InputMethodSubtype} from which
     * {@link InputMethodSubtypeArray} will be created.
     */
    public InputMethodSubtypeArray(final List<InputMethodSubtype> subtypes) {
        if (subtypes == null) {
            mCount = 0;
            return;
        }
        mCount = subtypes.size();
        mInstance = subtypes.toArray(new InputMethodSubtype[mCount]);
    }


Number 563:
API Relative Path:
src.android.view.KeyCharacterMap.java-getEvents(char[])
Corresponding Source:
/**
     * Get an array of KeyEvent objects that if put into the input stream
     * could plausibly generate the provided sequence of characters.  It is
     * not guaranteed that the sequence is the only way to generate these
     * events or that it is optimal.
     * <p>
     * This function is primarily offered for instrumentation and testing purposes.
     * It may fail to map characters to key codes.  In particular, the key character
     * map for the {@link #BUILT_IN_KEYBOARD built-in keyboard} device id may be empty.
     * Consider using the key character map associated with the
     * {@link #VIRTUAL_KEYBOARD virtual keyboard} device id instead.
     * </p><p>
     * For robust text entry, do not use this function.  Instead construct a
     * {@link KeyEvent} with action code {@link KeyEvent#ACTION_MULTIPLE} that contains
     * the desired string using {@link KeyEvent#KeyEvent(long, String, int, int)}.
     * </p>
     *
     * @param chars The sequence of characters to generate.
     * @return An array of {@link KeyEvent} objects, or null if the given char array
     *         can not be generated using the current key character map.
     */
    public KeyEvent[] getEvents(char[] chars) {
        if (chars == null) {
            throw new IllegalArgumentException("chars must not be null.");
        }
        return nativeGetEvents(mPtr, chars);
    }


Number 564:
API Relative Path:
src.android.view.KeyCharacterMap.java-getKeyData(int-KeyData)
Corresponding Source:
/**
     * Get the character conversion data for a given key code.
     *
     * @param keyCode The keyCode to query.
     * @param results A {@link KeyData} instance that will be filled with the results.
     * @return True if the key was mapped.  If the key was not mapped, results is not modified.
     *
     * @deprecated instead use {@link KeyCharacterMap#getDisplayLabel(int)},
     * {@link KeyCharacterMap#getNumber(int)} or {@link KeyCharacterMap#get(int, int)}.
     */
    @Deprecated
    public boolean getKeyData(int keyCode, KeyData results) {
        if (results.meta.length < KeyData.META_LENGTH) {
            throw new IndexOutOfBoundsException(
                    "results.meta.length must be >= " + KeyData.META_LENGTH);
        }

        char displayLabel = nativeGetDisplayLabel(mPtr, keyCode);
        if (displayLabel == 0) {
            return false;
        }

        results.displayLabel = displayLabel;
        results.number = nativeGetNumber(mPtr, keyCode);
        results.meta[0] = nativeGetCharacter(mPtr, keyCode, 0);
        results.meta[1] = nativeGetCharacter(mPtr, keyCode, KeyEvent.META_SHIFT_ON);
        results.meta[2] = nativeGetCharacter(mPtr, keyCode, KeyEvent.META_ALT_ON);
        results.meta[3] = nativeGetCharacter(mPtr, keyCode,
                KeyEvent.META_ALT_ON | KeyEvent.META_SHIFT_ON);
        return true;
    }


Number 565:
API Relative Path:
src.android.view.KeyCharacterMap.java-getMatch(int-char[]-int)
Corresponding Source:
/**
     * Gets the first character in the character array that can be generated
     * by the specified key code.  If there are multiple choices, prefers
     * the one that would be generated with the specified meta key modifier state.
     *
     * @param keyCode The key code.
     * @param chars The array of matching characters to consider.
     * @param metaState The preferred meta key modifier state.
     * @return The matching associated character, or 0 if none.
     */
    public char getMatch(int keyCode, char[] chars, int metaState) {
        if (chars == null) {
            throw new IllegalArgumentException("chars must not be null.");
        }

        metaState = KeyEvent.normalizeMetaState(metaState);
        return nativeGetMatch(mPtr, keyCode, chars, metaState);
    }


Number 566:
API Relative Path:
src.android.view.KeyEvent.java-metaStateHasModifiers(int-int)
Corresponding Source:
/**
     * Returns true if only the specified modifier keys are pressed according to
     * the specified meta state.  Returns false if a different combination of modifier
     * keys are pressed.
     * <p>
     * For the purposes of this function, {@link #KEYCODE_CAPS_LOCK},
     * {@link #KEYCODE_SCROLL_LOCK}, and {@link #KEYCODE_NUM_LOCK} are
     * not considered modifier keys.  Consequently, this function ignores
     * {@link #META_CAPS_LOCK_ON}, {@link #META_SCROLL_LOCK_ON} and {@link #META_NUM_LOCK_ON}.
     * </p><p>
     * If the specified modifier mask includes directional modifiers, such as
     * {@link #META_SHIFT_LEFT_ON}, then this method ensures that the
     * modifier is pressed on that side.
     * If the specified modifier mask includes non-directional modifiers, such as
     * {@link #META_SHIFT_ON}, then this method ensures that the modifier
     * is pressed on either side.
     * If the specified modifier mask includes both directional and non-directional modifiers
     * for the same type of key, such as {@link #META_SHIFT_ON} and {@link #META_SHIFT_LEFT_ON},
     * then this method throws an illegal argument exception.
     * </p>
     *
     * @param metaState The meta state to consider.
     * @param modifiers The meta state of the modifier keys to check.  May be a combination
     * of modifier meta states as defined by {@link #getModifierMetaStateMask()}.  May be 0 to
     * ensure that no modifier keys are pressed.
     * @return True if only the specified modifier keys are pressed.
     * @throws IllegalArgumentException if the modifiers parameter contains invalid modifiers
     * @see #hasModifiers
     */
    public static boolean metaStateHasModifiers(int metaState, int modifiers) {
        // Note: For forward compatibility, we allow the parameter to contain meta states
        //       that we do not recognize but we explicitly disallow meta states that
        //       are not valid modifiers.
        if ((modifiers & META_INVALID_MODIFIER_MASK) != 0) {
            throw new IllegalArgumentException("modifiers must not contain "
                    + "META_CAPS_LOCK_ON, META_NUM_LOCK_ON, META_SCROLL_LOCK_ON, "
                    + "META_CAP_LOCKED, META_ALT_LOCKED, META_SYM_LOCKED, "
                    + "or META_SELECTING");
        }

        metaState = normalizeMetaState(metaState) & META_MODIFIER_MASK;
        metaState = metaStateFilterDirectionalModifiers(metaState, modifiers,
                META_SHIFT_ON, META_SHIFT_LEFT_ON, META_SHIFT_RIGHT_ON);
        metaState = metaStateFilterDirectionalModifiers(metaState, modifiers,
                META_ALT_ON, META_ALT_LEFT_ON, META_ALT_RIGHT_ON);
        metaState = metaStateFilterDirectionalModifiers(metaState, modifiers,
                META_CTRL_ON, META_CTRL_LEFT_ON, META_CTRL_RIGHT_ON);
        metaState = metaStateFilterDirectionalModifiers(metaState, modifiers,
                META_META_ON, META_META_LEFT_ON, META_META_RIGHT_ON);
        return metaState == modifiers;
    }


Number 567:
API Relative Path:
src.android.view.LayoutInflater.java-setFactory(Factory)
Corresponding Source:
/**
     * Attach a custom Factory interface for creating views while using
     * this LayoutInflater.  This must not be null, and can only be set once;
     * after setting, you can not change the factory.  This is
     * called on each element name as the xml is parsed. If the factory returns
     * a View, that is added to the hierarchy. If it returns null, the next
     * factory default {@link #onCreateView} method is called.
     * 
     * <p>If you have an existing
     * LayoutInflater and want to add your own factory to it, use
     * {@link #cloneInContext} to clone the existing instance and then you
     * can use this function (once) on the returned new instance.  This will
     * merge your own factory with whatever factory the original instance is
     * using.
     */
    public void setFactory(Factory factory) {
        if (mFactorySet) {
            throw new IllegalStateException("A factory has already been set on this LayoutInflater");
        }
        if (factory == null) {
            throw new NullPointerException("Given factory can not be null");
        }
        mFactorySet = true;
        if (mFactory == null) {
            mFactory = factory;
        } else {
            mFactory = new FactoryMerger(factory, null, mFactory, mFactory2);
        }
    }


Number 568:
API Relative Path:
src.android.view.LayoutInflater.java-setFactory2(Factory2)
Corresponding Source:
/**
     * Like {@link #setFactory}, but allows you to set a {@link Factory2}
     * interface.
     */
    public void setFactory2(Factory2 factory) {
        if (mFactorySet) {
            throw new IllegalStateException("A factory has already been set on this LayoutInflater");
        }
        if (factory == null) {
            throw new NullPointerException("Given factory can not be null");
        }
        mFactorySet = true;
        if (mFactory == null) {
            mFactory = mFactory2 = factory;
        } else {
            mFactory = mFactory2 = new FactoryMerger(factory, factory, mFactory, mFactory2);
        }
    }


Number 569:
API Relative Path:
src.android.view.LayoutInflater.java-setFilter(Filter)
Corresponding Source:
/**
     * Sets the {@link Filter} to by this LayoutInflater. If a view is attempted to be inflated
     * which is not allowed by the {@link Filter}, the {@link #inflate(int, ViewGroup)} call will
     * throw an {@link InflateException}. This filter will replace any previous filter set on this
     * LayoutInflater.
     * 
     * @param filter The Filter which restricts the set of Views that are allowed to be inflated.
     *        This filter will replace any previous filter set on this LayoutInflater.
     */
    public void setFilter(Filter filter) {
        mFilter = filter;
        if (filter != null) {
            mFilterMap = new HashMap<String, Boolean>();
        }
    }


Number 570:
API Relative Path:
src.android.view.MotionEvent.java-obtain(MotionEvent)
Corresponding Source:
/**
     * Create a new MotionEvent, copying from an existing one.
     */
    static public MotionEvent obtain(MotionEvent other) {
        if (other == null) {
            throw new IllegalArgumentException("other motion event must not be null");
        }

        MotionEvent ev = obtain();
        ev.mNativePtr = nativeCopy(ev.mNativePtr, other.mNativePtr, true /*keepHistory*/);
        return ev;
    }


Number 571:
API Relative Path:
src.android.view.MotionEvent.java-obtainNoHistory(MotionEvent)
Corresponding Source:
/**
     * Create a new MotionEvent, copying from an existing one, but not including
     * any historical point information.
     */
    static public MotionEvent obtainNoHistory(MotionEvent other) {
        if (other == null) {
            throw new IllegalArgumentException("other motion event must not be null");
        }

        MotionEvent ev = obtain();
        ev.mNativePtr = nativeCopy(ev.mNativePtr, other.mNativePtr, false /*keepHistory*/);
        return ev;
    }


Number 572:
API Relative Path:
src.android.view.MotionEvent.java-transform(Matrix)
Corresponding Source:
/**
     * Applies a transformation matrix to all of the points in the event.
     *
     * @param matrix The transformation matrix to apply.
     */
    public final void transform(Matrix matrix) {
        if (matrix == null) {
            throw new IllegalArgumentException("matrix must not be null");
        }

        nativeTransform(mNativePtr, matrix);
    }


Number 573:
API Relative Path:
src.android.view.Surface.java-copyFrom(SurfaceControl)
Corresponding Source:
/**
     * Copy another surface to this one.  This surface now holds a reference
     * to the same data as the original surface, and is -not- the owner.
     * This is for use by the window manager when returning a window surface
     * back from a client, converting it from the representation being managed
     * by the window manager to the representation the client uses to draw
     * in to it.
     * @hide
     */
    public void copyFrom(SurfaceControl other) {
        if (other == null) {
            throw new IllegalArgumentException("other must not be null");
        }

        long surfaceControlPtr = other.mNativeObject;
        if (surfaceControlPtr == 0) {
            throw new NullPointerException(
                    "SurfaceControl native object is null. Are you using a released SurfaceControl?");
        }
        long newNativeObject = nativeCreateFromSurfaceControl(surfaceControlPtr);

        synchronized (mLock) {
            if (mNativeObject != 0) {
                nativeRelease(mNativeObject);
            }
            setNativeObjectLocked(newNativeObject);
        }
    }


Number 574:
API Relative Path:
src.android.view.Surface.java-setCompatibilityTranslator(Translator)
Corresponding Source:
/**
     * Sets the translator used to scale canvas's width/height in compatibility
     * mode.
     */
    void setCompatibilityTranslator(Translator translator) {
        if (translator != null) {
            float appScale = translator.applicationScale;
            mCompatibleMatrix = new Matrix();
            mCompatibleMatrix.setScale(appScale, appScale);
        }
    }


Number 575:
API Relative Path:
src.android.view.Surface.java-Surface(SurfaceTexture)
Corresponding Source:
/**
     * Create Surface from a {@link SurfaceTexture}.
     *
     * Images drawn to the Surface will be made available to the {@link
     * SurfaceTexture}, which can attach them to an OpenGL ES texture via {@link
     * SurfaceTexture#updateTexImage}.
     *
     * @param surfaceTexture The {@link SurfaceTexture} that is updated by this
     * Surface.
     * @throws OutOfResourcesException if the surface could not be created.
     */
    public Surface(SurfaceTexture surfaceTexture) {
        if (surfaceTexture == null) {
            throw new IllegalArgumentException("surfaceTexture must not be null");
        }

        synchronized (mLock) {
            mName = surfaceTexture.toString();
            setNativeObjectLocked(nativeCreateFromSurfaceTexture(surfaceTexture));
        }
    }


Number 576:
API Relative Path:
src.android.view.Surface.java-transferFrom(Surface)
Corresponding Source:
/**
     * This is intended to be used by {@link SurfaceView#updateWindow} only.
     * @param other access is not thread safe
     * @hide
     * @deprecated
     */
    @Deprecated
    public void transferFrom(Surface other) {
        if (other == null) {
            throw new IllegalArgumentException("other must not be null");
        }
        if (other != this) {
            final long newPtr;
            synchronized (other.mLock) {
                newPtr = other.mNativeObject;
                other.setNativeObjectLocked(0);
            }

            synchronized (mLock) {
                if (mNativeObject != 0) {
                    nativeRelease(mNativeObject);
                }
                setNativeObjectLocked(newPtr);
            }
        }
    }


Number 577:
API Relative Path:
src.android.view.textservice.SentenceSuggestionsInfo.java-SentenceSuggestionsInfo(SuggestionsInfo[]-int[]-int[])
Corresponding Source:
/**
     * Constructor.
     * @param suggestionsInfos from the text service
     * @param offsets the array of offsets of suggestions
     * @param lengths the array of lengths of suggestions
     */
    public SentenceSuggestionsInfo(
            SuggestionsInfo[] suggestionsInfos, int[] offsets, int[] lengths) {
        if (suggestionsInfos == null || offsets == null || lengths == null) {
            throw new NullPointerException();
        }
        if (suggestionsInfos.length != offsets.length || offsets.length != lengths.length) {
            throw new IllegalArgumentException();
        }
        final int infoSize = suggestionsInfos.length;
        mSuggestionsInfos = Arrays.copyOf(suggestionsInfos, infoSize);
        mOffsets = Arrays.copyOf(offsets, infoSize);
        mLengths = Arrays.copyOf(lengths, infoSize);
    }


Number 578:
API Relative Path:
src.android.view.textservice.SentenceSuggestionsInfo.java-SentenceSuggestionsInfo(SuggestionsInfo[]-int[]-int[])
Corresponding Source:
/**
     * Constructor.
     * @param suggestionsInfos from the text service
     * @param offsets the array of offsets of suggestions
     * @param lengths the array of lengths of suggestions
     */
    public SentenceSuggestionsInfo(
            SuggestionsInfo[] suggestionsInfos, int[] offsets, int[] lengths) {
        if (suggestionsInfos == null || offsets == null || lengths == null) {
            throw new NullPointerException();
        }
        if (suggestionsInfos.length != offsets.length || offsets.length != lengths.length) {
            throw new IllegalArgumentException();
        }
        final int infoSize = suggestionsInfos.length;
        mSuggestionsInfos = Arrays.copyOf(suggestionsInfos, infoSize);
        mOffsets = Arrays.copyOf(offsets, infoSize);
        mLengths = Arrays.copyOf(lengths, infoSize);
    }


Number 579:
API Relative Path:
src.android.view.textservice.SpellCheckerSession.java-SpellCheckerSession(SpellCheckerInfo-ITextServicesManager-SpellCheckerSessionListener-SpellCheckerSubtype)
Corresponding Source:
/**
     * Constructor
     * @hide
     */
    public SpellCheckerSession(
            SpellCheckerInfo info, ITextServicesManager tsm, SpellCheckerSessionListener listener,
            SpellCheckerSubtype subtype) {
        if (info == null || listener == null || tsm == null) {
            throw new NullPointerException();
        }
        mSpellCheckerInfo = info;
        mSpellCheckerSessionListenerImpl = new SpellCheckerSessionListenerImpl(mHandler);
        mInternalListener = new InternalListener(mSpellCheckerSessionListenerImpl);
        mTextServicesManager = tsm;
        mIsUsed = true;
        mSpellCheckerSessionListener = listener;
        mSubtype = subtype;
    }


Number 580:
API Relative Path:
src.android.view.textservice.TextServicesManager.java-newSpellCheckerSession(Bundle-Locale-SpellCheckerSessionListener-boolean)
Corresponding Source:
/**
     * Get a spell checker session for the specified spell checker
     * @param locale the locale for the spell checker. If {@code locale} is null and
     * referToSpellCheckerLanguageSettings is true, the locale specified in Settings will be
     * returned. If {@code locale} is not null and referToSpellCheckerLanguageSettings is true,
     * the locale specified in Settings will be returned only when it is same as {@code locale}.
     * Exceptionally, when referToSpellCheckerLanguageSettings is true and {@code locale} is
     * only language (e.g. "en"), the specified locale in Settings (e.g. "en_US") will be
     * selected.
     * @param listener a spell checker session lister for getting results from a spell checker.
     * @param referToSpellCheckerLanguageSettings if true, the session for one of enabled
     * languages in settings will be returned.
     * @return the spell checker session of the spell checker
     */
    public SpellCheckerSession newSpellCheckerSession(Bundle bundle, Locale locale,
            SpellCheckerSessionListener listener, boolean referToSpellCheckerLanguageSettings) {
        if (listener == null) {
            throw new NullPointerException();
        }
        if (!referToSpellCheckerLanguageSettings && locale == null) {
            throw new IllegalArgumentException("Locale should not be null if you don't refer"
                    + " settings.");
        }

        if (referToSpellCheckerLanguageSettings && !isSpellCheckerEnabled()) {
            return null;
        }

        final SpellCheckerInfo sci;
        try {
            sci = sService.getCurrentSpellChecker(null);
        } catch (RemoteException e) {
            return null;
        }
        if (sci == null) {
            return null;
        }
        SpellCheckerSubtype subtypeInUse = null;
        if (referToSpellCheckerLanguageSettings) {
            subtypeInUse = getCurrentSpellCheckerSubtype(true);
            if (subtypeInUse == null) {
                return null;
            }
            if (locale != null) {
                final String subtypeLocale = subtypeInUse.getLocale();
                final String subtypeLanguage = parseLanguageFromLocaleString(subtypeLocale);
                if (subtypeLanguage.length() < 2 || !locale.getLanguage().equals(subtypeLanguage)) {
                    return null;
                }
            }
        } else {
            final String localeStr = locale.toString();
            for (int i = 0; i < sci.getSubtypeCount(); ++i) {
                final SpellCheckerSubtype subtype = sci.getSubtypeAt(i);
                final String tempSubtypeLocale = subtype.getLocale();
                final String tempSubtypeLanguage = parseLanguageFromLocaleString(tempSubtypeLocale);
                if (tempSubtypeLocale.equals(localeStr)) {
                    subtypeInUse = subtype;
                    break;
                } else if (tempSubtypeLanguage.length() >= 2 &&
                        locale.getLanguage().equals(tempSubtypeLanguage)) {
                    subtypeInUse = subtype;
                }
            }
        }
        if (subtypeInUse == null) {
            return null;
        }
        final SpellCheckerSession session = new SpellCheckerSession(
                sci, sService, listener, subtypeInUse);
        try {
            sService.getSpellCheckerService(sci.getId(), subtypeInUse.getLocale(),
                    session.getTextServicesSessionListener(),
                    session.getSpellCheckerSessionListener(), bundle);
        } catch (RemoteException e) {
            return null;
        }
        return session;
    }


Number 581:
API Relative Path:
src.android.view.textservice.TextServicesManager.java-newSpellCheckerSession(Bundle-Locale-SpellCheckerSessionListener-boolean)
Corresponding Source:
/**
     * Get a spell checker session for the specified spell checker
     * @param locale the locale for the spell checker. If {@code locale} is null and
     * referToSpellCheckerLanguageSettings is true, the locale specified in Settings will be
     * returned. If {@code locale} is not null and referToSpellCheckerLanguageSettings is true,
     * the locale specified in Settings will be returned only when it is same as {@code locale}.
     * Exceptionally, when referToSpellCheckerLanguageSettings is true and {@code locale} is
     * only language (e.g. "en"), the specified locale in Settings (e.g. "en_US") will be
     * selected.
     * @param listener a spell checker session lister for getting results from a spell checker.
     * @param referToSpellCheckerLanguageSettings if true, the session for one of enabled
     * languages in settings will be returned.
     * @return the spell checker session of the spell checker
     */
    public SpellCheckerSession newSpellCheckerSession(Bundle bundle, Locale locale,
            SpellCheckerSessionListener listener, boolean referToSpellCheckerLanguageSettings) {
        if (listener == null) {
            throw new NullPointerException();
        }
        if (!referToSpellCheckerLanguageSettings && locale == null) {
            throw new IllegalArgumentException("Locale should not be null if you don't refer"
                    + " settings.");
        }

        if (referToSpellCheckerLanguageSettings && !isSpellCheckerEnabled()) {
            return null;
        }

        final SpellCheckerInfo sci;
        try {
            sci = sService.getCurrentSpellChecker(null);
        } catch (RemoteException e) {
            return null;
        }
        if (sci == null) {
            return null;
        }
        SpellCheckerSubtype subtypeInUse = null;
        if (referToSpellCheckerLanguageSettings) {
            subtypeInUse = getCurrentSpellCheckerSubtype(true);
            if (subtypeInUse == null) {
                return null;
            }
            if (locale != null) {
                final String subtypeLocale = subtypeInUse.getLocale();
                final String subtypeLanguage = parseLanguageFromLocaleString(subtypeLocale);
                if (subtypeLanguage.length() < 2 || !locale.getLanguage().equals(subtypeLanguage)) {
                    return null;
                }
            }
        } else {
            final String localeStr = locale.toString();
            for (int i = 0; i < sci.getSubtypeCount(); ++i) {
                final SpellCheckerSubtype subtype = sci.getSubtypeAt(i);
                final String tempSubtypeLocale = subtype.getLocale();
                final String tempSubtypeLanguage = parseLanguageFromLocaleString(tempSubtypeLocale);
                if (tempSubtypeLocale.equals(localeStr)) {
                    subtypeInUse = subtype;
                    break;
                } else if (tempSubtypeLanguage.length() >= 2 &&
                        locale.getLanguage().equals(tempSubtypeLanguage)) {
                    subtypeInUse = subtype;
                }
            }
        }
        if (subtypeInUse == null) {
            return null;
        }
        final SpellCheckerSession session = new SpellCheckerSession(
                sci, sService, listener, subtypeInUse);
        try {
            sService.getSpellCheckerService(sci.getId(), subtypeInUse.getLocale(),
                    session.getTextServicesSessionListener(),
                    session.getSpellCheckerSessionListener(), bundle);
        } catch (RemoteException e) {
            return null;
        }
        return session;
    }


Number 582:
API Relative Path:
src.android.view.TextureView.java-setSurfaceTexture(SurfaceTexture)
Corresponding Source:
/**
     * Set the {@link SurfaceTexture} for this view to use. If a {@link
     * SurfaceTexture} is already being used by this view, it is immediately
     * released and not be usable any more.  The {@link
     * SurfaceTextureListener#onSurfaceTextureDestroyed} callback is <b>not</b>
     * called for the previous {@link SurfaceTexture}.  Similarly, the {@link
     * SurfaceTextureListener#onSurfaceTextureAvailable} callback is <b>not</b>
     * called for the {@link SurfaceTexture} passed to setSurfaceTexture.
     *
     * The {@link SurfaceTexture} object must be detached from all OpenGL ES
     * contexts prior to calling this method.
     *
     * @param surfaceTexture The {@link SurfaceTexture} that the view should use.
     * @see SurfaceTexture#detachFromGLContext()
     */
    public void setSurfaceTexture(SurfaceTexture surfaceTexture) {
        if (surfaceTexture == null) {
            throw new NullPointerException("surfaceTexture must not be null");
        }
        if (surfaceTexture == mSurface) {
            throw new IllegalArgumentException("Trying to setSurfaceTexture to " +
                    "the same SurfaceTexture that's already set.");
        }
        if (surfaceTexture.isReleased()) {
            throw new IllegalArgumentException("Cannot setSurfaceTexture to a " +
                    "released SurfaceTexture");
        }
        if (mSurface != null) {
            mSurface.release();
        }
        mSurface = surfaceTexture;

        /*
         * If the view is visible and we already made a layer, update the
         * listener in the new surface to use the existing listener in the view.
         * Otherwise this will be called when the view becomes visible or the
         * layer is created
         */
        if (((mViewFlags & VISIBILITY_MASK) == VISIBLE) && mLayer != null) {
            mSurface.setOnFrameAvailableListener(mUpdateListener, mAttachInfo.mHandler);
        }
        mUpdateSurface = true;
        invalidateParentIfNeeded();
    }


Number 583:
API Relative Path:
src.android.view.TextureView.java-setSurfaceTexture(SurfaceTexture)
Corresponding Source:
/**
     * Set the {@link SurfaceTexture} for this view to use. If a {@link
     * SurfaceTexture} is already being used by this view, it is immediately
     * released and not be usable any more.  The {@link
     * SurfaceTextureListener#onSurfaceTextureDestroyed} callback is <b>not</b>
     * called for the previous {@link SurfaceTexture}.  Similarly, the {@link
     * SurfaceTextureListener#onSurfaceTextureAvailable} callback is <b>not</b>
     * called for the {@link SurfaceTexture} passed to setSurfaceTexture.
     *
     * The {@link SurfaceTexture} object must be detached from all OpenGL ES
     * contexts prior to calling this method.
     *
     * @param surfaceTexture The {@link SurfaceTexture} that the view should use.
     * @see SurfaceTexture#detachFromGLContext()
     */
    public void setSurfaceTexture(SurfaceTexture surfaceTexture) {
        if (surfaceTexture == null) {
            throw new NullPointerException("surfaceTexture must not be null");
        }
        if (surfaceTexture == mSurface) {
            throw new IllegalArgumentException("Trying to setSurfaceTexture to " +
                    "the same SurfaceTexture that's already set.");
        }
        if (surfaceTexture.isReleased()) {
            throw new IllegalArgumentException("Cannot setSurfaceTexture to a " +
                    "released SurfaceTexture");
        }
        if (mSurface != null) {
            mSurface.release();
        }
        mSurface = surfaceTexture;

        /*
         * If the view is visible and we already made a layer, update the
         * listener in the new surface to use the existing listener in the view.
         * Otherwise this will be called when the view becomes visible or the
         * layer is created
         */
        if (((mViewFlags & VISIBILITY_MASK) == VISIBLE) && mLayer != null) {
            mSurface.setOnFrameAvailableListener(mUpdateListener, mAttachInfo.mHandler);
        }
        mUpdateSurface = true;
        invalidateParentIfNeeded();
    }


Number 584:
API Relative Path:
src.android.view.VelocityTracker.java-addMovement(MotionEvent)
Corresponding Source:
/**
     * Add a user's movement to the tracker.  You should call this for the
     * initial {@link MotionEvent#ACTION_DOWN}, the following
     * {@link MotionEvent#ACTION_MOVE} events that you receive, and the
     * final {@link MotionEvent#ACTION_UP}.  You can, however, call this
     * for whichever events you desire.
     * 
     * @param event The MotionEvent you received and would like to track.
     */
    public void addMovement(MotionEvent event) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        }
        nativeAddMovement(mPtr, event);
    }


Number 585:
API Relative Path:
src.android.view.VelocityTracker.java-getEstimator(int-Estimator)
Corresponding Source:
/**
     * Get an estimator for the movements of a pointer using past movements of the
     * pointer to predict future movements.
     *
     * It is not necessary to call {@link #computeCurrentVelocity(int)} before calling
     * this method.
     *
     * @param id Which pointer's velocity to return.
     * @param outEstimator The estimator to populate.
     * @return True if an estimator was obtained, false if there is no information
     * available about the pointer.
     *
     * @hide For internal use only.  Not a final API.
     */
    public boolean getEstimator(int id, Estimator outEstimator) {
        if (outEstimator == null) {
            throw new IllegalArgumentException("outEstimator must not be null");
        }
        return nativeGetEstimator(mPtr, id, outEstimator);
    }


Number 586:
API Relative Path:
src.android.view.View.java-buildDrawingCache(boolean)
Corresponding Source:
/**
     * <p>Forces the drawing cache to be built if the drawing cache is invalid.</p>
     *
     * <p>If you call {@link #buildDrawingCache()} manually without calling
     * {@link #setDrawingCacheEnabled(boolean) setDrawingCacheEnabled(true)}, you
     * should cleanup the cache by calling {@link #destroyDrawingCache()} afterwards.</p>
     *
     * <p>Note about auto scaling in compatibility mode: When auto scaling is not enabled,
     * this method will create a bitmap of the same size as this view. Because this bitmap
     * will be drawn scaled by the parent ViewGroup, the result on screen might show
     * scaling artifacts. To avoid such artifacts, you should call this method by setting
     * the auto scaling to true. Doing so, however, will generate a bitmap of a different
     * size than the view. This implies that your application must be able to handle this
     * size.</p>
     *
     * <p>You should avoid calling this method when hardware acceleration is enabled. If
     * you do not need the drawing cache bitmap, calling this method will increase memory
     * usage and cause the view to be rendered in software once, thus negatively impacting
     * performance.</p>
     *
     * @see #getDrawingCache()
     * @see #destroyDrawingCache()
     */
    public void buildDrawingCache(boolean autoScale) {
        if ((mPrivateFlags & PFLAG_DRAWING_CACHE_VALID) == 0 || (autoScale ?
                mDrawingCache == null : mUnscaledDrawingCache == null)) {
            if (Trace.isTagEnabled(Trace.TRACE_TAG_VIEW)) {
                Trace.traceBegin(Trace.TRACE_TAG_VIEW,
                        "buildDrawingCache/SW Layer for " + getClass().getSimpleName());
            }
            try {
                buildDrawingCacheImpl(autoScale);
            } finally {
                Trace.traceEnd(Trace.TRACE_TAG_VIEW);
            }
        }
    }


Number 587:
API Relative Path:
src.android.view.View.java-findViewWithTag(Object)
Corresponding Source:
/**
     * Look for a child view with the given tag.  If this view has the given
     * tag, return this view.
     *
     * @param tag The tag to search for, using "tag.equals(getTag())".
     * @return The View that has the given tag in the hierarchy or null
     */
    public final View findViewWithTag(Object tag) {
        if (tag == null) {
            return null;
        }
        return findViewWithTagTraversal(tag);
    }


Number 588:
API Relative Path:
src.android.view.View.java-getLocationInWindow(int[])
Corresponding Source:
/**
     * <p>Computes the coordinates of this view in its window. The argument
     * must be an array of two integers. After the method returns, the array
     * contains the x and y location in that order.</p>
     *
     * @param outLocation an array of two integers in which to hold the coordinates
     */
    public void getLocationInWindow(@Size(2) int[] outLocation) {
        if (outLocation == null || outLocation.length < 2) {
            throw new IllegalArgumentException("outLocation must be an array of two integers");
        }

        outLocation[0] = 0;
        outLocation[1] = 0;

        transformFromViewToWindowSpace(outLocation);
    }


Number 589:
API Relative Path:
src.android.view.View.java-onRestoreInstanceState(Parcelable)
Corresponding Source:
/**
     * Hook allowing a view to re-apply a representation of its internal state that had previously
     * been generated by {@link #onSaveInstanceState}. This function will never be called with a
     * null state.
     *
     * @param state The frozen state that had previously been returned by
     *        {@link #onSaveInstanceState}.
     *
     * @see #onSaveInstanceState()
     * @see #restoreHierarchyState(android.util.SparseArray)
     * @see #dispatchRestoreInstanceState(android.util.SparseArray)
     */
    @CallSuper
    protected void onRestoreInstanceState(Parcelable state) {
        mPrivateFlags |= PFLAG_SAVE_STATE_CALLED;
        if (state != null && !(state instanceof AbsSavedState)) {
            throw new IllegalArgumentException("Wrong state class, expecting View State but "
                    + "received " + state.getClass().toString() + " instead. This usually happens "
                    + "when two views of different type have the same id in the same hierarchy. "
                    + "This view's id is " + ViewDebug.resolveId(mContext, getId()) + ". Make sure "
                    + "other views do not use the same id.");
        }
        if (state != null && state instanceof BaseSavedState) {
            mStartActivityRequestWho = ((BaseSavedState) state).mStartActivityRequestWhoSaved;
        }
    }


Number 590:
API Relative Path:
src.android.view.View.java-requestUnbufferedDispatch(MotionEvent)
Corresponding Source:
/**
     * Request unbuffered dispatch of the given stream of MotionEvents to this View.
     *
     * Until this View receives a corresponding {@link MotionEvent#ACTION_UP}, ask that the input
     * system not batch {@link MotionEvent}s but instead deliver them as soon as they're
     * available. This method should only be called for touch events.
     *
     * <p class="note">This api is not intended for most applications. Buffered dispatch
     * provides many of benefits, and just requesting unbuffered dispatch on most MotionEvent
     * streams will not improve your input latency. Side effects include: increased latency,
     * jittery scrolls and inability to take advantage of system resampling. Talk to your input
     * professional to see if {@link #requestUnbufferedDispatch(MotionEvent)} is right for
     * you.</p>
     */
    public final void requestUnbufferedDispatch(MotionEvent event) {
        final int action = event.getAction();
        if (mAttachInfo == null
                || action != MotionEvent.ACTION_DOWN && action != MotionEvent.ACTION_MOVE
                || !event.isTouchEvent()) {
            return;
        }
        mAttachInfo.mUnbufferedDispatchRequested = true;
    }


Number 591:
API Relative Path:
src.android.view.View.java-scheduleDrawable(Drawable-Runnable-long)
Corresponding Source:
/**
     * Schedules an action on a drawable to occur at a specified time.
     *
     * @param who the recipient of the action
     * @param what the action to run on the drawable
     * @param when the time at which the action must occur. Uses the
     *        {@link SystemClock#uptimeMillis} timebase.
     */
    @Override
    public void scheduleDrawable(@NonNull Drawable who, @NonNull Runnable what, long when) {
        if (verifyDrawable(who) && what != null) {
            final long delay = when - SystemClock.uptimeMillis();
            if (mAttachInfo != null) {
                mAttachInfo.mViewRootImpl.mChoreographer.postCallbackDelayed(
                        Choreographer.CALLBACK_ANIMATION, what, who,
                        Choreographer.subtractFrameDelay(delay));
            } else {
                // Postpone the runnable until we know
                // on which thread it needs to run.
                getRunQueue().postDelayed(what, delay);
            }
        }
    }


Number 592:
API Relative Path:
src.android.view.View.java-setAnimation(Animation)
Corresponding Source:
/**
     * Sets the next animation to play for this view.
     * If you want the animation to play immediately, use
     * {@link #startAnimation(android.view.animation.Animation)} instead.
     * This method provides allows fine-grained
     * control over the start time and invalidation, but you
     * must make sure that 1) the animation has a start time set, and
     * 2) the view's parent (which controls animations on its children)
     * will be invalidated when the animation is supposed to
     * start.
     *
     * @param animation The next animation, or null.
     */
    public void setAnimation(Animation animation) {
        mCurrentAnimation = animation;

        if (animation != null) {
            // If the screen is off assume the animation start time is now instead of
            // the next frame we draw. Keeping the START_ON_FIRST_FRAME start time
            // would cause the animation to start when the screen turns back on
            if (mAttachInfo != null && mAttachInfo.mDisplayState == Display.STATE_OFF
                    && animation.getStartTime() == Animation.START_ON_FIRST_FRAME) {
                animation.setStartTime(AnimationUtils.currentAnimationTimeMillis());
            }
            animation.reset();
        }
    }


Number 593:
API Relative Path:
src.android.view.View.java-setClipBounds(Rect)
Corresponding Source:
/**
     * Sets a rectangular area on this view to which the view will be clipped
     * when it is drawn. Setting the value to null will remove the clip bounds
     * and the view will draw normally, using its full bounds.
     *
     * @param clipBounds The rectangular area, in the local coordinates of
     * this view, to which future drawing operations will be clipped.
     */
    public void setClipBounds(Rect clipBounds) {
        if (clipBounds == mClipBounds
                || (clipBounds != null && clipBounds.equals(mClipBounds))) {
            return;
        }
        if (clipBounds != null) {
            if (mClipBounds == null) {
                mClipBounds = new Rect(clipBounds);
            } else {
                mClipBounds.set(clipBounds);
            }
        } else {
            mClipBounds = null;
        }
        mRenderNode.setClipBounds(mClipBounds);
        invalidateViewProperty(false, false);
    }


Number 594:
API Relative Path:
src.android.view.View.java-setContentDescription(CharSequence)
Corresponding Source:
/**
     * Sets the {@link View}'s content description.
     * <p>
     * A content description briefly describes the view and is primarily used
     * for accessibility support to determine how a view should be presented to
     * the user. In the case of a view with no textual representation, such as
     * {@link android.widget.ImageButton}, a useful content description
     * explains what the view does. For example, an image button with a phone
     * icon that is used to place a call may use "Call" as its content
     * description. An image of a floppy disk that is used to save a file may
     * use "Save".
     *
     * @param contentDescription The content description.
     * @see #getContentDescription()
     * @attr ref android.R.styleable#View_contentDescription
     */
    @RemotableViewMethod
    public void setContentDescription(CharSequence contentDescription) {
        if (mContentDescription == null) {
            if (contentDescription == null) {
                return;
            }
        } else if (mContentDescription.equals(contentDescription)) {
            return;
        }
        mContentDescription = contentDescription;
        final boolean nonEmptyDesc = contentDescription != null && contentDescription.length() > 0;
        if (nonEmptyDesc && getImportantForAccessibility() == IMPORTANT_FOR_ACCESSIBILITY_AUTO) {
            setImportantForAccessibility(IMPORTANT_FOR_ACCESSIBILITY_YES);
            notifySubtreeAccessibilityStateChangedIfNeeded();
        } else {
            notifyViewAccessibilityStateChangedIfNeeded(
                    AccessibilityEvent.CONTENT_CHANGE_TYPE_CONTENT_DESCRIPTION);
        }
    }


Number 595:
API Relative Path:
src.android.view.View.java-setDisplayListProperties(RenderNode)
Corresponding Source:
/**
     * This method is called by getDisplayList() when a display list is recorded for a View.
     * It pushes any properties to the RenderNode that aren't managed by the RenderNode.
     */
    void setDisplayListProperties(RenderNode renderNode) {
        if (renderNode != null) {
            renderNode.setHasOverlappingRendering(getHasOverlappingRendering());
            renderNode.setClipToBounds(mParent instanceof ViewGroup
                    && ((ViewGroup) mParent).getClipChildren());

            float alpha = 1;
            if (mParent instanceof ViewGroup && (((ViewGroup) mParent).mGroupFlags &
                    ViewGroup.FLAG_SUPPORT_STATIC_TRANSFORMATIONS) != 0) {
                ViewGroup parentVG = (ViewGroup) mParent;
                final Transformation t = parentVG.getChildTransformation();
                if (parentVG.getChildStaticTransformation(this, t)) {
                    final int transformType = t.getTransformationType();
                    if (transformType != Transformation.TYPE_IDENTITY) {
                        if ((transformType & Transformation.TYPE_ALPHA) != 0) {
                            alpha = t.getAlpha();
                        }
                        if ((transformType & Transformation.TYPE_MATRIX) != 0) {
                            renderNode.setStaticMatrix(t.getMatrix());
                        }
                    }
                }
            }
            if (mTransformationInfo != null) {
                alpha *= getFinalAlpha();
                if (alpha < 1) {
                    final int multipliedAlpha = (int) (255 * alpha);
                    if (onSetAlpha(multipliedAlpha)) {
                        alpha = 1;
                    }
                }
                renderNode.setAlpha(alpha);
            } else if (alpha < 1) {
                renderNode.setAlpha(alpha);
            }
        }
    }


Number 596:
API Relative Path:
src.android.view.View.java-setForeground(Drawable)
Corresponding Source:
/**
     * Supply a Drawable that is to be rendered on top of all of the content in the view.
     *
     * @param foreground the Drawable to be drawn on top of the children
     *
     * @attr ref android.R.styleable#View_foreground
     */
    public void setForeground(Drawable foreground) {
        if (mForegroundInfo == null) {
            if (foreground == null) {
                // Nothing to do.
                return;
            }
            mForegroundInfo = new ForegroundInfo();
        }

        if (foreground == mForegroundInfo.mDrawable) {
            // Nothing to do
            return;
        }

        if (mForegroundInfo.mDrawable != null) {
            if (isAttachedToWindow()) {
                mForegroundInfo.mDrawable.setVisible(false, false);
            }
            mForegroundInfo.mDrawable.setCallback(null);
            unscheduleDrawable(mForegroundInfo.mDrawable);
        }

        mForegroundInfo.mDrawable = foreground;
        mForegroundInfo.mBoundsChanged = true;
        if (foreground != null) {
            if ((mPrivateFlags & PFLAG_SKIP_DRAW) != 0) {
                mPrivateFlags &= ~PFLAG_SKIP_DRAW;
            }
            foreground.setLayoutDirection(getLayoutDirection());
            if (foreground.isStateful()) {
                foreground.setState(getDrawableState());
            }
            applyForegroundTint();
            if (isAttachedToWindow()) {
                foreground.setVisible(getWindowVisibility() == VISIBLE && isShown(), false);
            }
            // Set callback last, since the view may still be initializing.
            foreground.setCallback(this);
        } else if ((mViewFlags & WILL_NOT_DRAW) != 0 && mBackground == null) {
            mPrivateFlags |= PFLAG_SKIP_DRAW;
        }
        requestLayout();
        invalidate();
    }


Number 597:
API Relative Path:
src.android.view.View.java-setLayerType(int-Paint)
Corresponding Source:
/**
     * <p>Specifies the type of layer backing this view. The layer can be
     * {@link #LAYER_TYPE_NONE}, {@link #LAYER_TYPE_SOFTWARE} or
     * {@link #LAYER_TYPE_HARDWARE}.</p>
     *
     * <p>A layer is associated with an optional {@link android.graphics.Paint}
     * instance that controls how the layer is composed on screen. The following
     * properties of the paint are taken into account when composing the layer:</p>
     * <ul>
     * <li>{@link android.graphics.Paint#getAlpha() Translucency (alpha)}</li>
     * <li>{@link android.graphics.Paint#getXfermode() Blending mode}</li>
     * <li>{@link android.graphics.Paint#getColorFilter() Color filter}</li>
     * </ul>
     *
     * <p>If this view has an alpha value set to < 1.0 by calling
     * {@link #setAlpha(float)}, the alpha value of the layer's paint is superseded
     * by this view's alpha value.</p>
     *
     * <p>Refer to the documentation of {@link #LAYER_TYPE_NONE},
     * {@link #LAYER_TYPE_SOFTWARE} and {@link #LAYER_TYPE_HARDWARE}
     * for more information on when and how to use layers.</p>
     *
     * @param layerType The type of layer to use with this view, must be one of
     *        {@link #LAYER_TYPE_NONE}, {@link #LAYER_TYPE_SOFTWARE} or
     *        {@link #LAYER_TYPE_HARDWARE}
     * @param paint The paint used to compose the layer. This argument is optional
     *        and can be null. It is ignored when the layer type is
     *        {@link #LAYER_TYPE_NONE}
     *
     * @see #getLayerType()
     * @see #LAYER_TYPE_NONE
     * @see #LAYER_TYPE_SOFTWARE
     * @see #LAYER_TYPE_HARDWARE
     * @see #setAlpha(float)
     *
     * @attr ref android.R.styleable#View_layerType
     */
    public void setLayerType(int layerType, @Nullable Paint paint) {
        if (layerType < LAYER_TYPE_NONE || layerType > LAYER_TYPE_HARDWARE) {
            throw new IllegalArgumentException("Layer type can only be one of: LAYER_TYPE_NONE, "
                    + "LAYER_TYPE_SOFTWARE or LAYER_TYPE_HARDWARE");
        }

        boolean typeChanged = mRenderNode.setLayerType(layerType);

        if (!typeChanged) {
            setLayerPaint(paint);
            return;
        }

        if (layerType != LAYER_TYPE_SOFTWARE) {
            // Destroy any previous software drawing cache if present
            // NOTE: even if previous layer type is HW, we do this to ensure we've cleaned up
            // drawing cache created in View#draw when drawing to a SW canvas.
            destroyDrawingCache();
        }

        mLayerType = layerType;
        mLayerPaint = mLayerType == LAYER_TYPE_NONE ? null : paint;
        mRenderNode.setLayerPaint(mLayerPaint);

        // draw() behaves differently if we are on a layer, so we need to
        // invalidate() here
        invalidateParentCaches();
        invalidate(true);
    }


Number 598:
API Relative Path:
src.android.view.View.java-setOverScrollMode(int)
Corresponding Source:
/**
     * Set the over-scroll mode for this view. Valid over-scroll modes are
     * {@link #OVER_SCROLL_ALWAYS} (default), {@link #OVER_SCROLL_IF_CONTENT_SCROLLS}
     * (allow over-scrolling only if the view content is larger than the container),
     * or {@link #OVER_SCROLL_NEVER}.
     *
     * Setting the over-scroll mode of a view will have an effect only if the
     * view is capable of scrolling.
     *
     * @param overScrollMode The new over-scroll mode for this view.
     */
    public void setOverScrollMode(int overScrollMode) {
        if (overScrollMode != OVER_SCROLL_ALWAYS &&
                overScrollMode != OVER_SCROLL_IF_CONTENT_SCROLLS &&
                overScrollMode != OVER_SCROLL_NEVER) {
            throw new IllegalArgumentException("Invalid overscroll mode " + overScrollMode);
        }
        mOverScrollMode = overScrollMode;
    }


Number 599:
API Relative Path:
src.android.view.View.java-setTag(int-Object)
Corresponding Source:
/**
     * Sets a tag associated with this view and a key. A tag can be used
     * to mark a view in its hierarchy and does not have to be unique within
     * the hierarchy. Tags can also be used to store data within a view
     * without resorting to another data structure.
     *
     * The specified key should be an id declared in the resources of the
     * application to ensure it is unique (see the <a
     * href="{@docRoot}guide/topics/resources/more-resources.html#Id">ID resource type</a>).
     * Keys identified as belonging to
     * the Android framework or not associated with any package will cause
     * an {@link IllegalArgumentException} to be thrown.
     *
     * @param key The key identifying the tag
     * @param tag An Object to tag the view with
     *
     * @throws IllegalArgumentException If they specified key is not valid
     *
     * @see #setTag(Object)
     * @see #getTag(int)
     */
    public void setTag(int key, final Object tag) {
        // If the package id is 0x00 or 0x01, it's either an undefined package
        // or a framework id
        if ((key >>> 24) < 2) {
            throw new IllegalArgumentException("The key must be an application-specific "
                    + "resource id.");
        }

        setKeyedTag(key, tag);
    }


Number 600:
API Relative Path:
src.android.view.View.java-setTagInternal(int-Object)
Corresponding Source:
/**
     * Variation of {@link #setTag(int, Object)} that enforces the key to be a
     * framework id.
     *
     * @hide
     */
    public void setTagInternal(int key, Object tag) {
        if ((key >>> 24) != 0x1) {
            throw new IllegalArgumentException("The key must be a framework-specific "
                    + "resource id.");
        }

        setKeyedTag(key, tag);
    }


Number 601:
API Relative Path:
src.android.view.View.java-transformFromViewToWindowSpace(int[])
Corresponding Source:
/** @hide */
    public void transformFromViewToWindowSpace(@Size(2) int[] inOutLocation) {
        if (inOutLocation == null || inOutLocation.length < 2) {
            throw new IllegalArgumentException("inOutLocation must be an array of two integers");
        }

        if (mAttachInfo == null) {
            // When the view is not attached to a window, this method does not make sense
            inOutLocation[0] = inOutLocation[1] = 0;
            return;
        }

        float position[] = mAttachInfo.mTmpTransformLocation;
        position[0] = inOutLocation[0];
        position[1] = inOutLocation[1];

        if (!hasIdentityMatrix()) {
            getMatrix().mapPoints(position);
        }

        position[0] += mLeft;
        position[1] += mTop;

        ViewParent viewParent = mParent;
        while (viewParent instanceof View) {
            final View view = (View) viewParent;

            position[0] -= view.mScrollX;
            position[1] -= view.mScrollY;

            if (!view.hasIdentityMatrix()) {
                view.getMatrix().mapPoints(position);
            }

            position[0] += view.mLeft;
            position[1] += view.mTop;

            viewParent = view.mParent;
         }

        if (viewParent instanceof ViewRootImpl) {
            // *cough*
            final ViewRootImpl vr = (ViewRootImpl) viewParent;
            position[1] -= vr.mCurScrollY;
        }

        inOutLocation[0] = Math.round(position[0]);
        inOutLocation[1] = Math.round(position[1]);
    }


Number 602:
API Relative Path:
src.android.view.View.java-unscheduleDrawable(Drawable-Runnable)
Corresponding Source:
/**
     * Cancels a scheduled action on a drawable.
     *
     * @param who the recipient of the action
     * @param what the action to cancel
     */
    @Override
    public void unscheduleDrawable(@NonNull Drawable who, @NonNull Runnable what) {
        if (verifyDrawable(who) && what != null) {
            if (mAttachInfo != null) {
                mAttachInfo.mViewRootImpl.mChoreographer.removeCallbacks(
                        Choreographer.CALLBACK_ANIMATION, what, who);
            }
            getRunQueue().removeCallbacks(what);
        }
    }


Number 603:
API Relative Path:
src.android.view.ViewGroup.java-addView(View-int)
Corresponding Source:
/**
     * Adds a child view. If no layout parameters are already set on the child, the
     * default parameters for this ViewGroup are set on the child.
     *
     * <p><strong>Note:</strong> do not invoke this method from
     * {@link #draw(android.graphics.Canvas)}, {@link #onDraw(android.graphics.Canvas)},
     * {@link #dispatchDraw(android.graphics.Canvas)} or any related method.</p>
     *
     * @param child the child view to add
     * @param index the position at which to add the child
     *
     * @see #generateDefaultLayoutParams()
     */
    public void addView(View child, int index) {
        if (child == null) {
            throw new IllegalArgumentException("Cannot add a null child view to a ViewGroup");
        }
        LayoutParams params = child.getLayoutParams();
        if (params == null) {
            params = generateDefaultLayoutParams();
            if (params == null) {
                throw new IllegalArgumentException("generateDefaultLayoutParams() cannot return null");
            }
        }
        addView(child, index, params);
    }


Number 604:
API Relative Path:
src.android.view.ViewGroup.java-addView(View-int-LayoutParams)
Corresponding Source:
/**
     * Adds a child view with the specified layout parameters.
     *
     * <p><strong>Note:</strong> do not invoke this method from
     * {@link #draw(android.graphics.Canvas)}, {@link #onDraw(android.graphics.Canvas)},
     * {@link #dispatchDraw(android.graphics.Canvas)} or any related method.</p>
     *
     * @param child the child view to add
     * @param index the position at which to add the child or -1 to add last
     * @param params the layout parameters to set on the child
     */
    public void addView(View child, int index, LayoutParams params) {
        if (DBG) {
            System.out.println(this + " addView");
        }

        if (child == null) {
            throw new IllegalArgumentException("Cannot add a null child view to a ViewGroup");
        }

        // addViewInner() will call child.requestLayout() when setting the new LayoutParams
        // therefore, we call requestLayout() on ourselves before, so that the child's request
        // will be blocked at our level
        requestLayout();
        invalidate(true);
        addViewInner(child, index, params, false);
    }


Number 605:
API Relative Path:
src.android.view.ViewGroup.java-addViewInLayout(View-int-LayoutParams-boolean)
Corresponding Source:
/**
     * Adds a view during layout. This is useful if in your onLayout() method,
     * you need to add more views (as does the list view for example).
     *
     * If index is negative, it means put it at the end of the list.
     *
     * @param child the view to add to the group
     * @param index the index at which the child must be added or -1 to add last
     * @param params the layout parameters to associate with the child
     * @param preventRequestLayout if true, calling this method will not trigger a
     *        layout request on child
     * @return true if the child was added, false otherwise
     */
    protected boolean addViewInLayout(View child, int index, LayoutParams params,
            boolean preventRequestLayout) {
        if (child == null) {
            throw new IllegalArgumentException("Cannot add a null child view to a ViewGroup");
        }
        child.mParent = null;
        addViewInner(child, index, params, preventRequestLayout);
        child.mPrivateFlags = (child.mPrivateFlags & ~PFLAG_DIRTY_MASK) | PFLAG_DRAWN;
        return true;
    }


Number 606:
API Relative Path:
src.android.view.ViewGroup.java-endViewTransition(View)
Corresponding Source:
/**
     * This method should always be called following an earlier call to
     * {@link #startViewTransition(View)}. The given View is finally removed from its parent
     * and will no longer be displayed. Note that this method does not perform the functionality
     * of removing a view from its parent; it just discontinues the display of a View that
     * has previously been removed.
     *
     * @return view The View object that has been removed but is being kept around in the visible
     * hierarchy by an earlier call to {@link #startViewTransition(View)}.
     */
    public void endViewTransition(View view) {
        if (mTransitioningViews != null) {
            mTransitioningViews.remove(view);
            final ArrayList<View> disappearingChildren = mDisappearingChildren;
            if (disappearingChildren != null && disappearingChildren.contains(view)) {
                disappearingChildren.remove(view);
                if (mVisibilityChangingChildren != null &&
                        mVisibilityChangingChildren.contains(view)) {
                    mVisibilityChangingChildren.remove(view);
                } else {
                    if (view.mAttachInfo != null) {
                        view.dispatchDetachedFromWindow();
                    }
                    if (view.mParent != null) {
                        view.mParent = null;
                    }
                }
                invalidate();
            }
        }
    }


Number 607:
API Relative Path:
src.android.view.ViewRootImpl.java-requestTransitionStart(LayoutTransition)
Corresponding Source:
/**
     * Add LayoutTransition to the list of transitions to be started in the next traversal.
     * This list will be cleared after the transitions on the list are start()'ed. These
     * transitionsa re added by LayoutTransition itself when it sets up animations. The setup
     * happens during the layout phase of traversal, which we want to complete before any of the
     * animations are started (because those animations may side-effect properties that layout
     * depends upon, like the bounding rectangles of the affected views). So we add the transition
     * to the list and it is started just prior to starting the drawing phase of traversal.
     *
     * @param transition The LayoutTransition to be started on the next traversal.
     *
     * @hide
     */
    public void requestTransitionStart(LayoutTransition transition) {
        if (mPendingTransitions == null || !mPendingTransitions.contains(transition)) {
            if (mPendingTransitions == null) {
                 mPendingTransitions = new ArrayList<LayoutTransition>();
            }
            mPendingTransitions.add(transition);
        }
    }


Number 608:
API Relative Path:
src.android.view.Window.java-addOnFrameMetricsAvailableListener(OnFrameMetricsAvailableListener-Handler)
Corresponding Source:
/**
     * Set an observer to collect frame stats for each frame rendererd in this window.
     *
     * Must be in hardware rendering mode.
     */
    public final void addOnFrameMetricsAvailableListener(
            @NonNull OnFrameMetricsAvailableListener listener,
            Handler handler) {
        final View decorView = getDecorView();
        if (decorView == null) {
            throw new IllegalStateException("can't observe a Window without an attached view");
        }

        if (listener == null) {
            throw new NullPointerException("listener cannot be null");
        }

        decorView.addFrameMetricsListener(this, listener, handler);
    }


Number 609:
API Relative Path:
src.android.view.Window.java-setContainer(Window)
Corresponding Source:
/**
     * Set the container for this window.  If not set, the DecorWindow
     * operates as a top-level window; otherwise, it negotiates with the
     * container to display itself appropriately.
     *
     * @param container The desired containing Window.
     */
    public void setContainer(Window container) {
        mContainer = container;
        if (container != null) {
            // Embedded screens never have a title.
            mFeatures |= 1<<FEATURE_NO_TITLE;
            mLocalFeatures |= 1<<FEATURE_NO_TITLE;
            container.mHasChildren = true;
        }
    }


Number 610:
API Relative Path:
src.android.view.WindowManagerGlobal.java-changeCanvasOpacity(IBinder-boolean)
Corresponding Source:
/** @hide */
    public void changeCanvasOpacity(IBinder token, boolean opaque) {
        if (token == null) {
            return;
        }
        synchronized (mLock) {
            for (int i = mParams.size() - 1; i >= 0; --i) {
                if (mParams.get(i).token == token) {
                    mRoots.get(i).changeCanvasOpacity(opaque);
                    return;
                }
            }
        }
    }


Number 611:
API Relative Path:
src.android.webkit.CookieSyncManager.java-createInstance(Context)
Corresponding Source:
/**
     * Create a singleton CookieSyncManager within a context
     * @param context
     * @return CookieSyncManager
     */
    public static synchronized CookieSyncManager createInstance(Context context) {
        if (context == null) {
            throw new IllegalArgumentException("Invalid context argument");
        }
        setGetInstanceIsAllowed();
        return getInstance();
    }


Number 612:
API Relative Path:
src.android.webkit.WebResourceResponse.java-setData(InputStream)
Corresponding Source:
/**
     * Sets the input stream that provides the resource response's data. Callers
     * must implement {@link InputStream#read(byte[]) InputStream.read(byte[])}.
     *
     * @param data the input stream that provides the resource response's data. Must not be a
     *             StringBufferInputStream.
     */
    public void setData(InputStream data) {
        checkImmutable();
        // If data is (or is a subclass of) StringBufferInputStream
        if (data != null && StringBufferInputStream.class.isAssignableFrom(data.getClass())) {
            throw new IllegalArgumentException("StringBufferInputStream is deprecated and must " +
                "not be passed to a WebResourceResponse");
        }
        mInputStream = data;
    }


Number 613:
API Relative Path:
src.android.webkit.WebResourceResponse.java-setStatusCodeAndReasonPhrase(int-String)
Corresponding Source:
/**
     * Sets the resource response's status code and reason phrase.
     *
     * @param statusCode the status code needs to be in the ranges [100, 299], [400, 599].
     *                   Causing a redirect by specifying a 3xx code is not supported.
     * @param reasonPhrase the phrase describing the status code, for example "OK". Must be non-null
     *                     and not empty.
     */
    public void setStatusCodeAndReasonPhrase(int statusCode, String reasonPhrase) {
        checkImmutable();
        if (statusCode < 100)
            throw new IllegalArgumentException("statusCode can't be less than 100.");
        if (statusCode > 599)
            throw new IllegalArgumentException("statusCode can't be greater than 599.");
        if (statusCode > 299 && statusCode < 400)
            throw new IllegalArgumentException("statusCode can't be in the [300, 399] range.");
        if (reasonPhrase == null)
            throw new IllegalArgumentException("reasonPhrase can't be null.");
        if (reasonPhrase.trim().isEmpty())
            throw new IllegalArgumentException("reasonPhrase can't be empty.");
        for (int i = 0; i < reasonPhrase.length(); i++) {
            int c = reasonPhrase.charAt(i);
            if (c > 0x7F) {
                throw new IllegalArgumentException(
                        "reasonPhrase can't contain non-ASCII characters.");
            }
        }
        mStatusCode = statusCode;
        mReasonPhrase = reasonPhrase;
    }


Number 614:
API Relative Path:
src.android.webkit.WebResourceResponse.java-setStatusCodeAndReasonPhrase(int-String)
Corresponding Source:
/**
     * Sets the resource response's status code and reason phrase.
     *
     * @param statusCode the status code needs to be in the ranges [100, 299], [400, 599].
     *                   Causing a redirect by specifying a 3xx code is not supported.
     * @param reasonPhrase the phrase describing the status code, for example "OK". Must be non-null
     *                     and not empty.
     */
    public void setStatusCodeAndReasonPhrase(int statusCode, String reasonPhrase) {
        checkImmutable();
        if (statusCode < 100)
            throw new IllegalArgumentException("statusCode can't be less than 100.");
        if (statusCode > 599)
            throw new IllegalArgumentException("statusCode can't be greater than 599.");
        if (statusCode > 299 && statusCode < 400)
            throw new IllegalArgumentException("statusCode can't be in the [300, 399] range.");
        if (reasonPhrase == null)
            throw new IllegalArgumentException("reasonPhrase can't be null.");
        if (reasonPhrase.trim().isEmpty())
            throw new IllegalArgumentException("reasonPhrase can't be empty.");
        for (int i = 0; i < reasonPhrase.length(); i++) {
            int c = reasonPhrase.charAt(i);
            if (c > 0x7F) {
                throw new IllegalArgumentException(
                        "reasonPhrase can't contain non-ASCII characters.");
            }
        }
        mStatusCode = statusCode;
        mReasonPhrase = reasonPhrase;
    }


Number 615:
API Relative Path:
src.android.webkit.WebResourceResponse.java-setStatusCodeAndReasonPhrase(int-String)
Corresponding Source:
/**
     * Sets the resource response's status code and reason phrase.
     *
     * @param statusCode the status code needs to be in the ranges [100, 299], [400, 599].
     *                   Causing a redirect by specifying a 3xx code is not supported.
     * @param reasonPhrase the phrase describing the status code, for example "OK". Must be non-null
     *                     and not empty.
     */
    public void setStatusCodeAndReasonPhrase(int statusCode, String reasonPhrase) {
        checkImmutable();
        if (statusCode < 100)
            throw new IllegalArgumentException("statusCode can't be less than 100.");
        if (statusCode > 599)
            throw new IllegalArgumentException("statusCode can't be greater than 599.");
        if (statusCode > 299 && statusCode < 400)
            throw new IllegalArgumentException("statusCode can't be in the [300, 399] range.");
        if (reasonPhrase == null)
            throw new IllegalArgumentException("reasonPhrase can't be null.");
        if (reasonPhrase.trim().isEmpty())
            throw new IllegalArgumentException("reasonPhrase can't be empty.");
        for (int i = 0; i < reasonPhrase.length(); i++) {
            int c = reasonPhrase.charAt(i);
            if (c > 0x7F) {
                throw new IllegalArgumentException(
                        "reasonPhrase can't contain non-ASCII characters.");
            }
        }
        mStatusCode = statusCode;
        mReasonPhrase = reasonPhrase;
    }


Number 616:
API Relative Path:
src.android.webkit.WebResourceResponse.java-setStatusCodeAndReasonPhrase(int-String)
Corresponding Source:
/**
     * Sets the resource response's status code and reason phrase.
     *
     * @param statusCode the status code needs to be in the ranges [100, 299], [400, 599].
     *                   Causing a redirect by specifying a 3xx code is not supported.
     * @param reasonPhrase the phrase describing the status code, for example "OK". Must be non-null
     *                     and not empty.
     */
    public void setStatusCodeAndReasonPhrase(int statusCode, String reasonPhrase) {
        checkImmutable();
        if (statusCode < 100)
            throw new IllegalArgumentException("statusCode can't be less than 100.");
        if (statusCode > 599)
            throw new IllegalArgumentException("statusCode can't be greater than 599.");
        if (statusCode > 299 && statusCode < 400)
            throw new IllegalArgumentException("statusCode can't be in the [300, 399] range.");
        if (reasonPhrase == null)
            throw new IllegalArgumentException("reasonPhrase can't be null.");
        if (reasonPhrase.trim().isEmpty())
            throw new IllegalArgumentException("reasonPhrase can't be empty.");
        for (int i = 0; i < reasonPhrase.length(); i++) {
            int c = reasonPhrase.charAt(i);
            if (c > 0x7F) {
                throw new IllegalArgumentException(
                        "reasonPhrase can't contain non-ASCII characters.");
            }
        }
        mStatusCode = statusCode;
        mReasonPhrase = reasonPhrase;
    }


Number 617:
API Relative Path:
src.android.webkit.WebView.java-WebView(Context-AttributeSet-int-int-Map-boolean)
Corresponding Source:
/**
     * @hide
     */
    @SuppressWarnings("deprecation")  // for super() call into deprecated base class constructor.
    protected WebView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes,
            Map<String, Object> javaScriptInterfaces, boolean privateBrowsing) {
        super(context, attrs, defStyleAttr, defStyleRes);
        if (context == null) {
            throw new IllegalArgumentException("Invalid context argument");
        }
        sEnforceThreadChecking = context.getApplicationInfo().targetSdkVersion >=
                Build.VERSION_CODES.JELLY_BEAN_MR2;
        checkThread();

        ensureProviderCreated();
        mProvider.init(javaScriptInterfaces, privateBrowsing);
        // Post condition of creating a webview is the CookieSyncManager.getInstance() is allowed.
        CookieSyncManager.setGetInstanceIsAllowed();
    }


Number 618:
API Relative Path:
src.android.webkit.WebView.java-zoomBy(float)
Corresponding Source:
/**
     * Performs a zoom operation in this WebView.
     *
     * @param zoomFactor the zoom factor to apply. The zoom factor will be clamped to the Webview's
     * zoom limits. This value must be in the range 0.01 to 100.0 inclusive.
     */
    public void zoomBy(float zoomFactor) {
        checkThread();
        if (zoomFactor < 0.01)
            throw new IllegalArgumentException("zoomFactor must be greater than 0.01.");
        if (zoomFactor > 100.0)
            throw new IllegalArgumentException("zoomFactor must be less than 100.");
        mProvider.zoomBy(zoomFactor);
    }


Number 619:
API Relative Path:
src.android.webkit.WebView.java-zoomBy(float)
Corresponding Source:
/**
     * Performs a zoom operation in this WebView.
     *
     * @param zoomFactor the zoom factor to apply. The zoom factor will be clamped to the Webview's
     * zoom limits. This value must be in the range 0.01 to 100.0 inclusive.
     */
    public void zoomBy(float zoomFactor) {
        checkThread();
        if (zoomFactor < 0.01)
            throw new IllegalArgumentException("zoomFactor must be greater than 0.01.");
        if (zoomFactor > 100.0)
            throw new IllegalArgumentException("zoomFactor must be less than 100.");
        mProvider.zoomBy(zoomFactor);
    }


Number 620:
API Relative Path:
src.android.webkit.WebViewDelegate.java-callDrawGlFunction(Canvas-long)
Corresponding Source:
/**
     * Calls the function specified with the nativeDrawGLFunctor functor pointer. This
     * functionality is used by the WebView for calling into their renderer from the
     * framework display lists.
     *
     * @param canvas a hardware accelerated canvas (see {@link Canvas#isHardwareAccelerated()})
     * @param nativeDrawGLFunctor the pointer to the native functor that implements
     *        system/core/include/utils/Functor.h
     * @throws IllegalArgumentException if the canvas is not hardware accelerated
     */
    public void callDrawGlFunction(Canvas canvas, long nativeDrawGLFunctor) {
        if (!(canvas instanceof DisplayListCanvas)) {
            // Canvas#isHardwareAccelerated() is only true for subclasses of HardwareCanvas.
            throw new IllegalArgumentException(canvas.getClass().getName()
                    + " is not a DisplayList canvas");
        }
        ((DisplayListCanvas) canvas).drawGLFunctor2(nativeDrawGLFunctor, null);
    }


Number 621:
API Relative Path:
src.android.webkit.WebViewDelegate.java-callDrawGlFunction(Canvas-long-Runnable)
Corresponding Source:
/**
     * Calls the function specified with the nativeDrawGLFunctor functor pointer. This
     * functionality is used by the WebView for calling into their renderer from the
     * framework display lists.
     *
     * @param canvas a hardware accelerated canvas (see {@link Canvas#isHardwareAccelerated()})
     * @param nativeDrawGLFunctor the pointer to the native functor that implements
     *        system/core/include/utils/Functor.h
     * @param releasedRunnable Called when this nativeDrawGLFunctor is no longer referenced by this
     *        canvas, so is safe to be destroyed.
     * @throws IllegalArgumentException if the canvas is not hardware accelerated
     */
    public void callDrawGlFunction(@NonNull Canvas canvas, long nativeDrawGLFunctor,
            @Nullable Runnable releasedRunnable) {
        if (!(canvas instanceof DisplayListCanvas)) {
            // Canvas#isHardwareAccelerated() is only true for subclasses of HardwareCanvas.
            throw new IllegalArgumentException(canvas.getClass().getName()
                    + " is not a DisplayList canvas");
        }
        ((DisplayListCanvas) canvas).drawGLFunctor2(nativeDrawGLFunctor, releasedRunnable);
    }


