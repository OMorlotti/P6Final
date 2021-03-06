<%@ include file="../jsp/header.jsp" %>

<h4>Liste des utilisateurs</h4>

<spring:if test="${!(sessionScope.currentUser.id eq -1)}">
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#userform">Ajouter un utilisateur</button>
</spring:if>

<div class="card mt-1<spring:if test="${!(sessionScope.currentUser.id eq -1)}"> collapse</spring:if>" id="userform">
    <div class="card-body">
        <form method="POST" action="/Escalade/user">

            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="lastname">Nom :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="lastname" id="lastname" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="firstname">Prénom :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="firstname" id="firstname" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="login">Login :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="login" id="login" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="password">Mot de passe<br />(6 car. mini) :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="password" name="password" minlength="6" id="password" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="sex">Sexe :</label>
                <div class="col-sm-10">
                    <select class="custom-select custom-select-sm" name="sex" id="sex">
                        <option value="F">Femme</option>
                        <option value="M">Homme</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="birthdate">Date de naissance :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="date" name="birthdate" id="birthdate" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="phone">Numéro de téléphone :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="phone" id="phone" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="email">Email :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="email" name="email" id="email" required="required" />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="role">Rôle :</label>
                <div class="col-sm-10">
                    <spring:choose>
                        <spring:when test="${sessionScope.currentUser.role eq 'ADMIN'}">
                            <select class="custom-select custom-select-sm" name="role">
                                <option value="GUEST" selected>Invité</option>
                                <option value="USER">Utilisateur non membre</option>
                                <option value="MEMBER">Utilisateur membre</option>
                                <option value="ADMIN">Administrateur</option>
                            </select>
                        </spring:when>
                        <spring:otherwise>
                            <input class="form-control form-control-sm" type="text" name="role" value="GUEST" id="role" readonly="readonly" required="required" />
                        </spring:otherwise>
                    </spring:choose>
                </div>
            </div>

            <div class="text-right">
                <button class="btn btn-primary" type="submit">Envoyer</button>
            </div>

        </form>
    </div>
</div>

<!-- La liste d'utilisateurs n'est affichée que pour les ADMINS -->

<spring:if test="${sessionScope.currentUser.role eq 'ADMIN'}">
<table class="table table-sm table-striped mt-2">
    <thead>
      <tr>
          <td>Login</td>
          <td>Prénom</td>
          <td>Nom de famille</td>
          <td></td>
          <td></td>
      </tr>
    </thead>
    <tbody>
        <spring:forEach var="user" items="${ users }">
        <tr>
            <td><spring:out value="${ user.login }" /></td>
            <td><spring:out value="${ user.firstName }" /></td>
            <td><spring:out value="${ user.lastName }" /></td>
            <td><a href="/Escalade/user/<spring:out value="${ user.id }" />">Voir/Editer</a></td>
            <td><a href="/Escalade/user/delete/<spring:out value="${ user.id }" />">Supprimer</a></td>
        </tr>
        </spring:forEach>
    </tbody>
</table>
</spring:if>

<%@ include file="../jsp/footer.jsp" %>